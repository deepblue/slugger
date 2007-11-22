require 'xmlrpc/client'

pingback_url = 'http://localhost:3000/xmlrpc'
source_uri   = 'http://deepblue.springnote.com/'
target_uri   = 'http://myruby.net/pages/601210'

server = XMLRPC::Client.new2(URI.parse(pingback_url).to_s)
p server.call('pingback.ping', source_uri, target_uri)
