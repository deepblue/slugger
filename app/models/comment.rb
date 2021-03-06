class Rme2day::Comment
  liquid_methods :id, :author_link, :created_at, :body, :presentation_class
  
  def id
    object_id
  end
  
  def author_link
    c = split
    c.length > 1 ? c.last : nickname
  end
  
  def created_at
    Time.parse(pubdate)
  end
  
  def split
    body.split(' by ')
  end
  
  def presentation_class
    'by-guest'  #  "by-author", "by-user"
  end
    
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
      setup(:post)
      Rme2day::Post.create "\"#{page.title}\":#{Site.home_url}/pages/#{page.id}", '', ''
    end
    
    def find(page)
      setup(:post)
      parse(Rme2day::API.get_comments(comment_id(page)))
    # rescue; []
    end
    
    def create(page, comment)
      body = "#{comment['body']} by #{author_link(comment)}"
      write_comment page, body
    end
    
    def create_pingback(page, uri)
      body = "Pingback from \"#{uri}\":#{uri}"
      write_comment page, body
    end
    
    # Message = Struct.new(:tb_url, :title, :excerpt, :url, :blog_name) 
    def create_trackback(page, message)
      title = "#{message[:title]} (#{message[:blog_name]})".gsub(/[\"']/, '')
      body = "Trackback from \"#{title}\":#{message[:url]}  - #{message[:excerpt]}"
      write_comment page, body      
    end
    
    def write_comment(page, body)
      cid = comment_id(page, true)
      
      setup(:comment)
      Rme2day::API.create_comment(cid, "(#{Site.title}) #{body}")
    end
    
    def author_link(comment)
      if comment['author_url'].blank? 
        comment['author'].to_s
      else
        url = comment['author_url']
        url = 'http://' + url unless url.starts_with?('http')
        "\"#{comment['author']}\":#{url}"
      end
    end
    
    def setup(mode = :post)
      user_id =  (mode != :post && Site.me2day_user_id_comment)  ? Site.me2day_user_id_comment  : Site.me2day_user_id
      user_key = (mode != :post && Site.me2day_user_key_comment) ? Site.me2day_user_key_comment : Site.me2day_user_key
      
      Rme2day::API.setup(user_id, user_key, ME2DAY_APP_KEY)
    end
  end  
end

Comment = Rme2day::Comment
