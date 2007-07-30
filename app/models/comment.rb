class Comment
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
      Rme2day::Post.create "\"#{page.title}\":#{Site.home_url}/pages/#{page.id}", '', ''
    end
    
    def find(page)
      Rme2day::Comment.parse(Rme2day::API.get_comments(comment_id(page)))
    rescue; []
    end
    
    def create(page, comment)
      cid = comment_id(page, true)
      body = "(#{Site.site_title}) #{comment['body']} by \"#{comment['author']}\""
      body += ":#{comment['author_url']}" unless comment['author_url'].blank? 
      Rme2day::API.create_comment(cid, body)
    end
  end
end