module Output where

import Types (User(User))
import Control.Concurrent(MVar, readMVar)

printUser :: User -> IO ()
printUser (User username count) = do
    counter <- readMVar count
    putStrLn $ "\nUsername: " ++ username ++ "\nMessage count: " ++ show (counter :: Int)

printUsers :: [User] -> IO ()
printUsers [] = putStrLn "" -- stackoverflow says this should work
printUsers (a:b) = do
    printUser a
    printUsers b