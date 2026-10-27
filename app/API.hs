{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DataKinds #-}

module API where 
import Data.IORef (IORef, atomicModifyIORef', readIORef)
import Servant (Server, Handler (Handler), Post, Get, Capture, JSON)
import Servant.API ((:>), (:<|>) (..))
import Lucid (Html)
import Declarations 
import Front
import Control.Monad.IO.Class (MonadIO(liftIO))


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
