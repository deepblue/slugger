class PingbackAPI < ActionWebService::API::Base
  inflect_names false
  
  api_method :ping, :returns => [:string], :expects => [
    {:sourceURI => :string},
    {:targetURI => :string}
  ]
end