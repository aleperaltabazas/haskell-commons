module Options.Class
  ( Options (..),
  setProgramHeader
  )
where

import           Data.Maybe.Extra
import           Options.Applicative
import           Prelude
import           System.Environment  (lookupEnv, setEnv)

programHeader :: String
programHeader = "PROGRAM_HEADER"

setProgramHeader :: String -> IO ()
setProgramHeader = setEnv programHeader

class Options o where
  options :: Parser o

  parseArgs :: [String] -> IO o
  parseArgs args = do
    h <- lookupEnv programHeader
    let opts = info (options <**> helper) (fullDesc <> ((header <$> h) ?: mempty))
    let result = execParserPure defaultPrefs opts args
    handleParseResult result

