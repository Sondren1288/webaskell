module Front where

import Lucid (Html)
import Lucid (ToHtml (toHtml), renderBS, HtmlT, Html, p_, style_, button_, data_, Attribute, span_, id_, doctypehtml_, script_, src_, body_, head_, title_)
import Lucid.Base (makeAttribute)

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
