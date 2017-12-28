module Lib
    ( someFunc
    ) where

import           System.Console.ANSI

printRed :: String -> IO ()
printRed str = do
    setSGR [SetColor Foreground Vivid Red]
    putStrLn str
    setSGR []

someFunc :: IO ()
someFunc = printRed "Hello World!"
