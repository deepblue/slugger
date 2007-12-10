class Site
  liquid_methods :title, :subtitle, :theme, :feed_path, :home_url, :sidebar, :google_analytics, :lemonpen_sid, :theme_name
  
  def method_missing(name)
    SITE_SETTINGS[name.to_s]
  end
  
  def theme
    @theme ||= Theme.new(theme_name || 'default')
  end
  
  def sidebar
    Page.side
  end

  class <<self
    def method_missing(name)
      SITE_SETTINGS[name.to_s]
    end
  end
end