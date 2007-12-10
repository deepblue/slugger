require 'xmlrpc/client'

pingback_url = 'http://myruby.net/xmlrpc'
source_uri   = 'http://me2day.net/deepblue/2007/12/02#21:51:28'
target_uri   = 'http://myruby.net/pages/627247'

server = XMLRPC::Client.new2(URI.parse(pingback_url).to_s)
p server.call('pingback.ping', source_uri, target_uri)
