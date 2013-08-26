{-# LANGUAGE OverloadedStrings #-}
--------------------------------------------------------------------------------
import Data.Monoid (mconcat)
import Control.Applicative ((<$>))
-- import Control.Monad.Trans
import Hakyll
--------------------------------------------------------------------------------
normalPages :: Pattern
normalPages = fromList
  [ "index.md"
  ]

sassCompiler :: Compiler (Item String)
sassCompiler = do
  source <- getResourceString
  withItemBody (unixFilter "sass" []) source

macroContext :: String -> Context String
macroContext source = mconcat $ map partialMacro macros
  where macros = (read source) :: [(String, String)]
        makePartialString filename = "$partial(\"templates/" ++ filename ++ "\")$"
        partialMacro (name, filename) = constField name $ makePartialString filename

myPandocCompiler :: Compiler (Item String)
myPandocCompiler = do
  macroCtx <- macroContext <$> (loadBody $ fromFilePath "partialmacros.hs")
  res <- getResourceString
  macroed <- applyAsTemplate macroCtx res
  partialed <- applyAsTemplate defaultContext macroed
  return . renderPandoc $ partialed

main :: IO ()
main = hakyll $ do
  match ("images/*" .||. "js/*" .||. "css/*.css" .||. "fonts/*") $ do
    route   idRoute
    compile copyFileCompiler
  match "css/*.sass" $ do
    route   $ setExtension "css"
    compile sassCompiler
  match "templates/*" $ compile templateCompiler
  match "partialmacros.hs" $ do
    compile getResourceBody
  match normalPages $ do
    route $ setExtension "html"
    compile $ myPandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" defaultContext
      >>= relativizeUrls
