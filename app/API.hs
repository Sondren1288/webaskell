{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DataKinds #-}

module API where 
import Servant (Server, Get,  serveDirectoryWebApp)
import Servant.API ((:>), (:<|>) (..), Raw)
import Lucid (Html)
import Declarations 
import qualified Front



type API = Get '[HTMLLucid] (Html ())
      :<|> "cv" :> Get '[HTMLLucid] (Html ()) -- cv on web
      -- :<|> "cv" :> "download" :> Raw          -- cs as pdf (might be better to do as a button on the cv page)
      :<|> "static" :> Raw                    -- CSS


apiServer :: Server API
apiServer = landingPage
       :<|> cvPage
       -- :<|> cvDownload
       :<|> cssPage
       where landingPage = pure Front.homePage
             cvPage      = pure Front.cvPage
             cvDownload = undefined
             cssPage = serveDirectoryWebApp "static"
        

