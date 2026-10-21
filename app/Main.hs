{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE OverloadedStrings #-}



module Main (main) where

import Data.Text
import Data.Time (UTCTime)
import Data.ByteString (ByteString)
import Servant.API (Accept, contentType, MimeRender (mimeRender), Get, (:>), JSON)
import Network.HTTP.Media ((//), (/:))
import Lucid (ToHtml (toHtml), renderBS, HtmlT, Html)
import Data.Proxy (Proxy (..))
import Data.Void (Void)
import Servant (Server, Application, serve)
import Network.Wai.Handler.Warp (run)


data HTMLLucid

instance Accept HTMLLucid where 
  contentType _ = "text" // "HTML" /: ("charset", "utf-8")


instance ToHtml a => MimeRender HTMLLucid a where 
  mimeRender _ = renderBS . toHtml

instance MimeRender HTMLLucid (Html a) where
  mimeRender _ = renderBS

type Tester = Get '[JSON, HTMLLucid] String

testAPI :: Proxy Tester
testAPI = Proxy

server :: Server Tester 
server = return "HAHAH"

app :: Application 
app = serve testAPI server


main :: IO ()
main = do 
      putStrLn "Hello, Haskell!"
      run 8080 app
