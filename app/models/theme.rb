class Theme
  attr_reader :name
  liquid_methods :name, :stylesheet_url
  
  def initialize(name)
    @name = name
  end

  def root
    @root ||= self.class.root + '/' + @name
  end
  
  def template(name)
    "#{root}/templates/#{name}.liquid"
  end
  
  def layout
    "#{root}/layouts/layout.liquid"
  end
  
  def stylesheet_url(stylesheet)
    stylesheet << '.css' unless stylesheet.include? '.'
    "/themes/#{name}/stylesheets/#{stylesheet}"
  end  

  def javascript_url(javascript)
    javascript << '.js' unless javascript.include? '.'
    "/themes/#{name}/javascripts/#{javascript}"
  end  
  
  class <<self
    def root
      @root ||= RAILS_ROOT + "/themes"
    end
    
    def install_public_symlink
      dir = RAILS_ROOT + '/public/themes'
      File.symlink(root, dir) unless File.exists?(dir)
    end
  end
end
