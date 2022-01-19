module Types (User(User, username, count)) where

import Control.Concurrent (MVar)
    
data User = User {
    username :: String, -- username serves as an id
    count :: MVar Int -- count of messages received
} deriving (Eq)