{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DataKinds #-}

module API where 
import Servant (Server, Get,  serveDirectoryWebApp)
import Servant.API ((:>), (:<|>) (..), Raw)
import Lucid (Html)
import Declarations 
import qualified Front



type API = Get '[HTMLLucid] (Html ())
      -- :<|> "cv" :> Get '[HTMLLucid] (Html ()) -- cv on web
      -- :<|> "cv" :> "download" :> Raw          -- cs as pdf
      :<|> "static" :> Raw                    -- CSS


apiServer :: Server API
apiServer = landingPage
       -- :<|> cvPage
       -- :<|> cvDownload
       :<|> cssPage
       where landingPage = return Front.landingPage
             cvPage = undefined
             cvDownload = undefined
             cssPage = serveDirectoryWebApp "static"
        

