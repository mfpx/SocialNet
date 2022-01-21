{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Concurrent
import Control.Monad
import System.Random (randomIO, random, randomRIO)
import Text.StringRandom
import Data.Text (pack)
import Types
import Rand (genUUID, generateRandomMessage)
import Data.UUID

-- |Instantiates a new object of type User
-- Takes Int as user ID (UID)
genUserInstance :: Int -> User
genUserInstance id = do
    let uuid = genUUID id
    User id uuid 0 [] -- counts are zero, and messages are empty

-- |Updates message counts, and adds the message to the user object
-- Takes User object and a message to be added to the user
userRecv :: User -> Message -> User
userRecv user msg
    | uid user == destination msg = user {count = count user + 1, messages = msg: messages user}
    | uid user == origin msg = user {messages = msg: messages user}
    | otherwise = user -- nothing happens if no match

-- |Final textual outputs, this displays the UID, UUID and their message counts
result :: User -> IO ()
result user = putStrLn $ "SocialNet user " ++  show (uid user) ++ " (with UUID " ++ uuid user ++ ") has " ++ show (count user) ++ " messages"

-- |Retrieves a random UID for further processing
retrUserID :: Int -> IO Int
retrUserID u_self = do
    n <- randomIO
    let dest = mod n 10 + 1

    if dest == u_self then
        retrUserID u_self
    else
        return dest

-- |Forks the main process
mapFork :: MVar [User] -> MVar Int -> MVar Int -> [Int] -> IO () -- MVar? maybe?
mapFork users gtr total forkedp =
    forM_ forkedp $ \n ->
    forkIO (sendReceive n users gtr total) -- fork the process, produce child processes

-- |Updates a passed in MVar
updateMVar :: MVar a -> a -> IO ()
updateMVar = putMVar

-- |Main function which runs the simulation
-- Takes an Int as UID, Users MVar for stats, gtr MVar to be filled and totals to update
sendReceive :: Int -> MVar [User] -> MVar Int -> MVar Int -> IO ()
sendReceive uid users gtr total = do
    t <- takeMVar total
    u <- takeMVar users
    if t == 100 then do
        putStrLn "--- Simulation finished ---"
        putMVar gtr uid
        updateMVar users u
        return ()
    else do
        destination <- retrUserID uid
        randMsg <- generateRandomMessage

        let msg = Message {content = randMsg, destination = destination, origin = uid}
        print msg

        let u' = map v u
            v x = userRecv x msg

        let t' = t + 1
        putMVar total t'
        putMVar users u'
        rng <- randomRIO (10, 1000000) 
        threadDelay rng  -- this seems to be bugged
        sendReceive uid users gtr total

main = do
    total <- newMVar 0
    gtr <- newEmptyMVar
    users <- newMVar (map genUserInstance [1..10])

    putStrLn "--- Message exchanges ---"
    mapFork users gtr total [1..10] -- fork child processes

    w <- takeMVar gtr
    u <- takeMVar users
    mapM_ result u
