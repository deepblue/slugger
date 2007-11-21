require 'pingback_service'

class XmlrpcController < ApplicationController
  session :off
  
  web_service_dispatching_mode :layered
  web_service :pingback, PingbackService.new
end