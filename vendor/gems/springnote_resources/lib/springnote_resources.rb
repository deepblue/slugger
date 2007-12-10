$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

unless defined?(ActiveResource)
  begin
    $:.unshift(File.dirname(__FILE__) + "/../vendor/activeresource/lib")
    require 'active_resource'  
  rescue LoadError
    require 'rubygems'
    gem 'activeresource'
  end
end

require 'springnote/configuration'
require 'springnote/base'
require 'springnote/page'
require 'springnote/attachment'
require 'springnote/lock'
require 'springnote/revision'

