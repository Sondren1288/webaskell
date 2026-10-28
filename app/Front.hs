{-# LANGUAGE OverloadedStrings #-}
module Front where

import Data.Text (Text)
import Lucid (ToHtml (toHtml), renderBS, HtmlT, Html, p_, style_, button_, data_, Attribute, span_, id_, doctypehtml_, script_, src_, body_, head_, title_, div_, tr_, td_, form_, label_, table_, action_, method_, type_, name_, br_, for_, input_)
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
    div_ [] $ nameList store
           <> nameListForm
      


textFieldButton :: Html ()
textFieldButton = button_ [hxPost_ "/words/append", hxTarget_ "#text-append", hxSwap_ ""] "Submit"

-- Shared fragment
nameList :: MainIn -> Html ()
nameList store = table_ [id_ "names"] 
               $ mapM_ (tr_ . td_ [style_ "color:green"] . toHtml) (stringList store)

nameListForm :: Html ()
nameListForm = form_ [ hxPost_ "/addname"
                     , hxTarget_ "#names"
                     , hxSwap_ "outerHTML"
                     , makeAttribute "hx-on::after-request" "this.reset()"
                     ] $
    do label_ [for_ "nameadder"] "Add name or whatever"
       input_ [type_ "text", id_ "nameadder", name_ "nameadder"]
       br_ []
       button_ [type_ "submit"] "Submit"


