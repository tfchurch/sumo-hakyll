{-# LANGUAGE OverloadedStrings, QuasiQuotes #-}
--------------------------------------------------------------------------------
import Data.Monoid (mconcat)
import Control.Applicative ((<$>))
import Hakyll
import Text.Regex
import Debug.Trace
import Text.Pandoc
import Text.InterpolatedString.Perl6
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

myPandocCompiler :: Compiler (Item String)
myPandocCompiler = do
  macroCtx <- macroContext <$> (loadBody $ fromFilePath "partialmacros.hs")
  res <- getResourceString
  macroed <- applyAsTemplate macroCtx res
  partialed <- applyAsTemplate defaultContext macroed
  return . postProcessor . myRenderPandoc $ partialed
  where postProcessor = fmap $ prettifyTables . obfuscateEmails
        myRenderPandoc = writePandoc . (fmap pandocProcessor) . readPandoc

-- TODO: make these ugly regex things use pandoc and pattern matching
obfuscateEmails :: String -> String
obfuscateEmails source = subRegex emailRegex source "<a href=\"mailto:\\0\">\\1 at \\2</a>"
  where emailRegex = mkRegex "([.[:alnum:]\\-]+)@([.[:alnum:]]+[:alnum:])"

prettifyTables :: String -> String
prettifyTables source = subRegex (mkRegex "<table>") source "<table class=\"table\">"

pandocProcessor :: Pandoc -> Pandoc
pandocProcessor = bottomUp replaceWithButton

replaceWithButton :: Block -> Block
replaceWithButton (Para ((Str "!!!largebutton"):_:xs)) = 
  let (Link text dest) = head xs
  in Para $ RawInline "html" 
    [qq|<a class="btn btn-primary btn-lg" href={show $ fst dest}>|] 
    : text ++ [RawInline "html" "</a>"]
replaceWithButton b = b

main :: IO ()
main = hakyllWith conf $ do
  match ("images/*" .||. "js/*.js" .||. "css/*.css"
    .||. "fonts/*" .||. "pdfs/**") $ do
    route   idRoute
    compile copyFileCompiler
  match "js/*.coffee" $ do
    route   $ setExtension "js"
    compile coffeeCompiler
  match "css/*.sass" $ do
    route   $ setExtension "css"
    compile sassCompiler
  match "templates/*" $ compile templateCompiler
  match "partialmacros.hs" $ do
    compile getResourceBody
  match "pages/*.md" $ do
    route $ (gsubRoute "pages/" $ const "") `composeRoutes` setExtension "html"
    compile $ myPandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" defaultContext
      >>= relativizeUrls
  where conf = defaultConfiguration { deployCommand = "./deploy" }
