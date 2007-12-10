require 'cgi'

module Springnote
  class MissingConfiguration < RuntimeError; end
  
  class Configuration
    attr_writer :app_key, :user_key, :user_openid
    SERVER_PROTOCOL = 'https'
    SERVER_URL = "api.springnote.com"

    def site
      "#{SERVER_PROTOCOL}://#{username}:#{password}@#{SERVER_URL}/"
    end
    
    def load(file)
      set YAML.load(File.read(file))
    end
        
    def set(options)
      options.each{|k,v| self.send("#{k}=", v)}
      Springnote::Base.site = self.site
      self
    end
    
    def username
      CGI.escape(@user_openid || 'anonymous')
    end
        
    def password
      @user_key ? [@user_key, app_key].join('.') : app_key
    end
    
    def app_key
      @app_key or raise MissingConfiguration
    end
  end
end # module Springnote
