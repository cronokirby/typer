-- pulled from https://github.com/rcook/hidden-char
module System.IO.HiddenChar.Posix (getHiddenChar) where

import           Control.Exception
import           System.IO

data HandleState = HandleState BufferMode Bool

hGetState :: Handle -> IO HandleState
hGetState h = do
    bufferMode <- hGetBuffering h
    isEcho <- hGetEcho h
    return $ HandleState bufferMode isEcho

hSetState :: Handle -> HandleState -> IO ()
hSetState h (HandleState mode isEcho) = do
    hSetEcho h isEcho
    hSetBuffering h mode

bracketHandle :: Handle -> (IO a -> IO a)
bracketHandle h action = bracket
    (hGetState h)
    (hSetState h)
    (const action)

-- | Read a character from the standard input device with buffering and echoing disabled
getHiddenChar ::
    IO Char -- ^ returned character
getHiddenChar = bracketHandle stdin $ do
    hSetBuffering stdin NoBuffering
    hSetEcho stdin False
    getChar
