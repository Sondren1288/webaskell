{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}



module Main (main) where

import Data.Text (Text)
import Data.Time (UTCTime)
import Data.ByteString (ByteString)
import Servant.API (Accept, contentType, MimeRender (mimeRender), Get, (:>), JSON, Post, ReqBody, (:<|>) (..), Capture, Verb, Header)
import Network.HTTP.Media ((//), (/:))
import Lucid (ToHtml (toHtml), renderBS, HtmlT, Html, p_, style_, button_, data_, Attribute, span_, id_, doctypehtml_, script_, src_, body_, head_, title_)
import Lucid.Base (makeAttribute)
import Data.Proxy (Proxy (..))
import Data.Void (Void)
import Servant (Server, Application, serve, Handler (Handler), Headers, StdMethod (POST), NoContent (NoContent), addHeader)
import Network.Wai.Handler.Warp (run)
import Data.IORef (newIORef, IORef, atomicModifyIORef, readIORef, atomicModifyIORef')
import GHC.Generics (Generic)
import Data.Aeson (ToJSON)
import Control.Monad.IO.Class (MonadIO(liftIO))
import Front
import Declarations




counterValue :: IO (IORef Int)
counterValue = newIORef 0

type IncrementAPI = "counter" :> "increment" :> Post '[HTMLLucid] (Html ()) --Verb 'POST 303 '[HTMLLucid] (Headers '[Header "Location" Text] NoContent)
               :<|> "counter" :> Get '[HTMLLucid] (Html ())
               :<|> "position" :> Capture "x" Int :> Capture "y" Int :> Get '[JSON] Position -- something like "position/x/y -> {xPos: x, yPos: y} (except, numeric) 


incrementServer :: IORef Int -> Server IncrementAPI
incrementServer ref = increment
                 :<|> showCounter 
                 :<|> retPos
                 where increment = do
                          n <- liftIO $ atomicModifyIORef' ref (\n -> (n + 1, n + 1))
                          return $ countView n

                       showCounter = do
                          n <- liftIO $ readIORef ref
                          return $ counterPage n -- p_ [style_ "color:green"] (toHtml (show n))

                       retPos :: Int -> Int -> Handler Position
                       retPos x y = return $ Position x y



increProx :: Proxy IncrementAPI
increProx = Proxy


type Tester = Get '[HTMLLucid] (Html ())

retVal :: Html () 
retVal = p_ [style_ "color:red"] "I am some porter of great renown"

testAPI :: Proxy Tester
testAPI = Proxy

server :: Server Tester 
server = return retVal

app :: Application 
app = serve testAPI server

incrementApp :: IORef Int -> Application
incrementApp ref = serve increProx (incrementServer ref)


main :: IO ()
main = do 
      --fast <- newIORef 4
      putStrLn "Hello, Haskell!"
      ref <- newIORef 0
      run 8080 (incrementApp ref)
