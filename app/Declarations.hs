{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Declarations where

import Lucid.Base (makeAttribute, Attribute, ToHtml (toHtml), renderBS)
import Data.Text (Text)
import Servant.API (MimeRender (mimeRender), Accept (contentType))
import Network.HTTP.Media ((//), (/:))


-- Create the types so that they don't need to be re-written. 
-- Generally equivalent to data_ "hx-<>"
hxPost_, hxTarget_, hxSwap_ :: Text -> Attribute
hxPost_   = makeAttribute "hx-post"
hxTarget_ = makeAttribute "hx-target"
hxSwap_   = makeAttribute "hx-swap"

data HTMLLucid

instance Accept HTMLLucid where 
  contentType _ = "text" // "HTML" /: ("charset", "utf-8")


instance ToHtml a => MimeRender HTMLLucid a where 
  mimeRender _ = renderBS . toHtml
