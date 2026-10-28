{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE BlockArguments #-}
module Front where

import Data.Text (Text)
import Lucid (ToHtml (toHtml), HtmlT, Html, p_, style_, button_, data_, Attribute, span_, id_, doctypehtml_, script_, src_, body_, head_, title_, div_, tr_, td_, form_, label_, table_, action_, method_, type_, name_, br_, for_, input_, link_, class_, rel_, href_, h1_)
import Lucid.Base (makeAttribute)
import Declarations


layout :: Text -> Html () -> Html ()
layout title content = doctypehtml_ $ do
  head_ $ do
    title_ (toHtml title)
    script_ [src_ "https://unpkg.com/htmx.org@2.0.11"] ("" :: Text)
    link_ [rel_ "stylesheet", href_ "/static/style.css"]
  body_ $ do
    div_ [class_ "starter"] content
    



homePage :: Html ()
homePage = layout "CV" $ do 
    h1_ "Sondre Nordmoen"
    p_ "You are viewing the CV of Sondre Nordmoen"
      

cvPage :: Html ()
cvPage = layout "CV - Details" $ 
    p_ "Other page"

