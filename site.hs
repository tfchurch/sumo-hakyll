{-# LANGUAGE OverloadedStrings, QuasiQuotes #-}
--------------------------------------------------------------------------------
import Data.Monoid (mconcat, (<>))
import Control.Applicative
import Hakyll
import Text.Regex
import Text.Pandoc
import Text.InterpolatedString.Perl6
-- import Debug.Trace
--------------------------------------------------------------------------------
sassCompiler :: Compiler (Item String)
sassCompiler = getResourceString >>=
  withItemBody (unixFilter "sass" [])

coffeeCompiler :: Compiler (Item String)
coffeeCompiler = getResourceString >>=
  withItemBody (unixFilter "coffee" ["-s", "-c"])

macroContext :: String -> Context String
macroContext source = mconcat $ map partialMacro macros
  where macros = (read source) :: [(String, String)]
        makePartialString filename =
          "$partial(\"templates/" ++ filename ++ "\")$"
        partialMacro (name, filename) =
          constField name $ makePartialString filename

myPandocCompiler :: Compiler (Item String, [Block])
myPandocCompiler = do
  macroCtx <- macroContext <$> (loadBody $ fromFilePath "partialmacros.hs")
  res <- getResourceString
  macroed <- applyAsTemplate macroCtx res
  partialed <- applyAsTemplate defaultContext macroed
  let pandoc = fmap pandocProcessor . readPandoc $ partialed
  return (postProcessor $ writePandoc pandoc, grabHeaders pandoc)
  where
    postProcessor = fmap $ prettifyTables . obfuscateEmails
    grabHeaders pandocItem = filter isHeader pandocContent
      where
        (Pandoc _ pandocContent) = itemBody pandocItem
        isHeader (Header _ _ _) = True
        isHeader _ = False
    -- myRenderPandoc = writePandoc . (fmap pandocProcessor) . readPandoc

-- TODO: make these ugly regex things use pandoc and pattern matching
obfuscateEmails :: String -> String
obfuscateEmails source = subRegex emailRegex source "<a href=\"mailto:\\0\">\\1 at \\2</a>"
  where emailRegex = mkRegex "([.[:alnum:]\\-]+)@([.[:alnum:]]+[:alnum:])"

prettifyTables :: String -> String
prettifyTables source = subRegex (mkRegex "<table>") source "<table class=\"table\">"

pandocProcessor :: Pandoc -> Pandoc
pandocProcessor = bottomUp replaceWithButton

replaceWithButton :: Block -> Block
replaceWithButton (Para ((Str "!!!smallbutton"):_:link:_)) =
  let (Link text dest) = link
      openTag = RawInline "html"
        [qc|<a class="btn btn-primary" href={fst dest}>|]
      closeTag = RawInline "html" "</a>"
  in Para $ openTag : text ++ [closeTag]
replaceWithButton (Para ((Str "!!!largebutton"):_:link:_)) =
  let (Link text dest) = link
      openTag = RawInline "html"
        [qc|<a class="btn btn-primary btn-lg" href={fst dest}>|]
      closeTag = RawInline "html" "</a>"
  in Para $ openTag : text ++ [closeTag]
replaceWithButton b = b

sidenavContext :: [Block] -> Context String
sidenavContext headers = constField "sidenavcontent" pandocStr
  where
    headerToLi :: Block -> Block
    headerToLi (Header _ (titleId, ["title"], _) titleText) = Plain $
      (RawInline "html" 
        ("<a class=\"sidenavTitle\" href=\"#" ++ titleId ++ "\">")
      ) : titleText ++ [RawInline "html" "</a>"]
    headerToLi (Header 1 (headerId, _, _) text) = Plain 
      [Link text ('#':headerId, "")]
    headerToLi _ = Null
    pandocStr = itemBody $ writePandoc $ Item "" $ Pandoc (Meta [] [] []) 
      [BulletList $ map pure $ filter notNull $ map headerToLi headers]
    notNull Null = False
    notNull _ = True
-- sidenavContext _ = error "No title on page, cannot construct sidenav"

main :: IO ()
main = hakyllWith conf $ do
  match ("images/*" .||. "js/*.js" .||. "css/*.css"
    .||. "fonts/*" .||. "pdfs/**") $ do
    route idRoute
    compile copyFileCompiler
  match "js/*.coffee" $ do
    route $ setExtension "js"
    compile coffeeCompiler
  match "css/*.sass" $ do
    route $ setExtension "css"
    compile sassCompiler
  match "templates/*" $ compile templateCompiler
  match "partialmacros.hs" $ do
    compile getResourceBody
  match "pages/**.md" $ do
    route $ (gsubRoute "pages/" $ const "") `composeRoutes` setExtension "html"
    compile $ do
      (compPandoc, headers) <- myPandocCompiler
      let withNavContext = sidenavContext headers <> defaultContext
      templated <- loadAndApplyTemplate "templates/default.html"
                     withNavContext compPandoc
      relativizeUrls templated
      -- >>=
      -- >>= relativizeUrls
  where conf = defaultConfiguration { deployCommand = "./deploy" }
