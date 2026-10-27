{-# LANGUAGE OverloadedStrings #-}
module Front where

import Data.Text (Text)
import Lucid (ToHtml (toHtml), renderBS, HtmlT, Html, p_, style_, button_, data_, Attribute, span_, id_, doctypehtml_, script_, src_, body_, head_, title_, div_, tr_, td_, form_, label_)
import Lucid.Base (makeAttribute)
import Declarations

counterPage :: Int -> Html ()
counterPage n = doctypehtml_ $ do
  head_ $ do
    title_ "Counter"
    script_ [src_ "https://unpkg.com/htmx.org@2.0.11"] ("" :: Text)
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


frontPage :: MainIn -> Html ()
frontPage store = doctypehtml_ $ do
  head_ $ do
    title_ "Front"
    script_ [src_ "https://unpkg.com/htmx.org@2.0.11"] ("" :: Text)
  body_ $ do
    div_ [style_ "color:green"] $ 
      do p_ [style_ "color:teal; font: italic; font-size: 36pt"] "Welcome one and all"
         p_ [style_ "color:black"] "To a not-so-beutiful webpage"
    div_ [] $
      do tr_ [] $ mapM_ (td_ [style_ "color:green"]) (stringList store)
      


textFieldButton :: Html ()
textFieldButton = button_ [hxPost_ "/words/append", hxTarget_ "#text-append", hxSwap_ ""] "Submit"

formed = form_ [] $ 
    do label_ "1"
       label_ "2"

