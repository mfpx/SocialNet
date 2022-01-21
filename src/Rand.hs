{-# LANGUAGE RankNTypes #-}
module Rand(generateRandomMessage, genUUID) where

import System.IO
import Control.Monad
import Control.Monad.Random
import Types
import System.Random
import Control.Concurrent(readMVar)
import Text.Read(readMaybe)
import Data.UUID
import Data.Text (Text, pack)

-- |Reads a file and returns its contents
-- Takes filename as String
readInputFile :: String -> IO [String]
readInputFile fname = do
        handle <- openFile fname ReadMode
        contents <- hGetContents handle
        let words = lines contents
        return words

-- |Produces a random element using MonadRandom
-- Takes a list of Strings to select items from
giveRandomElement :: [String] -> (MonadRandom m) => m String
giveRandomElement lst = do
    let n = length lst
    i <- getRandomR (0, n-1)
    return (lst !! i)

-- |Generates a random message from a word file of messages
-- Returns a message as String
generateRandomMessage :: IO String
generateRandomMessage = do
    lst <- readInputFile "words.txt" -- sentences generated using https://randomwordgenerator.com/sentence.php
    giveRandomElement lst

-- |Returns a String representation of UUID
-- Takes UID as Int to be used as a seed 
genUUID :: Int -> String
genUUID n =
  let seed = n -- seed will be uid
      g0 = mkStdGen seed
      (u1, g1) = random g0
  in toString u1




