class Comment
  @@configuration = nil
    
  class <<self
    def comment_id(page, create = false)
      map = Page.property.json || {}
      map['comments'] ||= {}
      
      if create && !map['comments'][page.id]
        map['comments'][page.id] = create_map(page).permalink
        Page.property.json = map
      end
      map['comments'][page.id]
    end
    
    def create_map(page)
      setup('post')
      Rme2day::Post.create "\"#{page.title}\":#{Site.home_url}/pages/#{page.id}", '', ''
    end
    
    def find(page)
      setup('post')
      Rme2day::Comment.parse(Rme2day::API.get_comments(comment_id(page)))
    rescue; []
    end
    
    def create(page, comment)
      cid = comment_id(page, true)
      body = "(#{Site.site_title}) #{comment['body']} by \"#{comment['author']}\""
      body += ":#{comment['author_url']}" unless comment['author_url'].blank? 
      
      setup('comment')
      Rme2day::API.create_comment(cid, body)
    end
    
    def setup(mode = 'post')
      Rme2day::API.setup(configuration[mode]['user_id'], configuration[mode]['user_key'], configuration['app_key'])
    end

    def configuration
      @@configuration ||= YAML.load(File.read(M2DAY_CONFIGURATION_FILE))
    end    
  end
end