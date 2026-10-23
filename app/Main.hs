{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE OverloadedStrings #-}



module Main (main) where

import Data.Text
import Data.Time (UTCTime)
import Data.ByteString (ByteString)
import Servant.API (Accept, contentType, MimeRender (mimeRender), Get, (:>), JSON)
import Network.HTTP.Media ((//), (/:))
import Lucid (ToHtml (toHtml), renderBS, HtmlT, Html, p_, style_, button_, data_)
import Lucid.Base (makeAttribute)
import Data.Proxy (Proxy (..))
import Data.Void (Void)
import Servant (Server, Application, serve)
import Network.Wai.Handler.Warp (run)
import Data.IORef (newIORef)


data HTMLLucid

instance Accept HTMLLucid where 
  contentType _ = "text" // "HTML" /: ("charset", "utf-8")


instance ToHtml a => MimeRender HTMLLucid a where 
  mimeRender _ = renderBS . toHtml


incrementAPI = "counter" :> "increment" :> Post '[HTMLLucid] (Html ())
      :<|> ""

--incrementButton = button_ [makeAttribute "hx-post" "/counter/increment"] ("+1" :: String)
incrementButton = button_ [data_ "hx-post" "/counter/increment", data_ "hx-target" "#count"] "+1"


type Tester = Get '[HTMLLucid] (Html ())

retVal :: Html () 
retVal = p_ [style_ "color:red"] "I am some porter of great renown"

testAPI :: Proxy Tester
testAPI = Proxy

server :: Server Tester 
server = return retVal

app :: Application 
app = serve testAPI server


main :: IO ()
main = do 
      fast <- newIORef 4
      putStrLn "Hello, Haskell!"
      run 8080 app
