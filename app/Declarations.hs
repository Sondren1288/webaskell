{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Declarations where


import Lucid.Base (makeAttribute, Attribute)
import Data.Text (Text)
import GHC.Generics (Generic)
import Data.Aeson (ToJSON)

hxPost_, hxTarget_, hxSwap_ :: Text -> Attribute
hxPost_   = makeAttribute "hx-post"
hxTarget_ = makeAttribute "hx-target"
hxSwap_   = makeAttribute "hx-swap"

data Position = Position 
  { xPos :: Int
  , yPos :: Int
  } deriving (Show, Generic)

instance ToJSON Position
