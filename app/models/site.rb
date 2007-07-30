class Site  
  class <<self
    def method_missing(name)
      SITE_SETTINGS[name.to_s]
    end
  end
end