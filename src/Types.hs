{-# LANGUAGE DeriveGeneric #-}

module Types (
    User (..), -- generic User type
    Message (..) -- generic Message type
) where

import GHC.Generics
import Control.Lens -- actually a very cool package (https://hackage.haskell.org/package/lens-5.1)
import Data.Text

data User = User {
    -- | UID is the user ID represented as String
    uid :: Int,
    -- | UUID is the Universally Unique Identifier represented as String
    uuid :: String,
    -- | Total message counts
    count :: Int,
    -- | A list of messages
    messages :: [Message] -- list of messages
} deriving (Eq, Show, Generic)

data Message = Message {
    -- | String representation of the message content
    content :: String,
    -- | UID of the sender
    origin :: Int,
    -- | UID of the receiver
    destination :: Int
} deriving (Eq, Show)

{-
data UID = UID {
   uuid :: UUID,
   elements :: String
} deriving (Show)
-}