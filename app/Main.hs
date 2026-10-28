{-# LANGUAGE OverloadedStrings #-}



module Main (main) where

import Data.Text (Text)
import Data.Proxy (Proxy (..))
import Servant (Application, serve)
import Network.Wai.Handler.Warp (run)
import Data.IORef (newIORef, IORef,)
import Declarations
import API


apiProxy :: Proxy API
apiProxy = Proxy


app :: Application 
app = serve apiProxy apiServer


main :: IO ()
main = do 
      putStrLn "Hello, Haskell!"
      run 8080 app
