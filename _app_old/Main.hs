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


app :: IORef MainIn -> Application 
app ref = serve apiProxy (apiServer ref)


constListStart :: [Text]
constListStart = ["I have a list", "The list consists of text", "The text is sacred", "Refrigerator"]

main :: IO ()
main = do 
      --fast <- newIORef 4
      putStrLn "Hello, Haskell!"
      ref <- newIORef (MainIn {stringList = constListStart})
      run 8080 (app ref)
