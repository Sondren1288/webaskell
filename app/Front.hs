{-# LANGUAGE OverloadedStrings #-}
module Front where

import Data.Text (Text)
import Lucid (ToHtml (toHtml), renderBS, HtmlT, Html, p_, style_, button_, data_, Attribute, span_, id_, doctypehtml_, script_, src_, body_, head_, title_)
import Lucid.Base (makeAttribute)
import Declarations

counterPage :: Int -> Html ()
counterPage n = doctypehtml_ $ do
  head_ $ do
    title_ "Counter"
    script_ [src_ "https://unpkg.com/htmx.org@2.0.4"] ("" :: Text)
  body_ $ do
    p_ [style_ "color:green"] $ do
      "Count: "
      countView n 
    incrementButton

incrementButton :: Html ()
incrementButton = button_ [hxPost_ "/counter/increment", hxTarget_ "#count", hxSwap_ "outerHTML"] "+1"


-- The fragment both routes share: the GET embeds it, the POST replaces it.
countView :: Int -> Html ()
countView n = span_ [id_ "count"] (toHtml (show n))
