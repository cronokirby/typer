-- pulled from https://github.com/rcook/hidden-char
{-# LANGUAGE CPP #-}

module System.IO.HiddenChar (getHiddenChar) where

#if defined(OS_LINUX) || defined(OS_MACOS)
import           System.IO.HiddenChar.Posix
#elif defined(OS_WINDOWS)
import           System.IO.HiddenChar.Windows
#else
#error Unsupported platform
#endif
