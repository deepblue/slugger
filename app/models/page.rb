class Page < Springnote::Page    
  class <<self    
    %w(index side property).each do |key|
      class_eval <<-EOS
        def #{key}(reload = false)
          return @#{key}_page if !reload && @#{key}_page
          @#{key}_page = find(Site.#{key}_page_id)
        end
      EOS
    end

    def list
      @page_list ||= index.source.to_s.scan(/<li>.*?<a.*?href=\"\/pages\/(\d+)\".*?>(.*?)<\/a>.*?<\/li>/mi).map{|m| m[0].to_i}
    end
    
    def blog_post?(id)
      list.include?(id.to_i)
    end
  end
  
  liquid_methods :id, :title, :body, :tags, :published_at, :accept_comments, :comments_count, :comments, :url
  
  def blog_post?
    Page.blog_post?(id)
  end
  
  def published_at
    date_modified
  end
  
  def accept_comments
    true
  end
  
  def comments_count
    comments.size
  rescue; 0
  end
  
  def comments
    @comments ||= Comment.find(self)
  rescue; []
  end
  
  def url
    "/pages/#{id}"
  end
  
  def content
    returning(source) do |cont|
      cont.gsub!(%r<"/pages/(\d+)(.*?)">) do |m|
        $2.blank? && Page.blog_post?($1.to_i) ? m : "\"http://#{Site.springnote_domain}/pages/#{$1}#{$2}\""
      end
      
      # Temporary convert #HTML DIV tag's contents into HTML
      cont.gsub!(%r{<div>.*?<p>#HTML</p>(.*?)</div>}mi) do |m|
        CGI.unescapeHTML($1.gsub(/<\/?p[^>]*?>/mi, '').gsub(/<br[^>]*?>/mi, ''))
      end
    end
  end  
  alias_method :body, :content  

  ########################
  # JSON Support
  
  def json
    ActiveSupport::JSON.decode(source.to_s.gsub(/<[^>]*?>/,'').gsub(/&.*?;/, ''))
  end
  
  def json=(prop)
    self.source = prop.to_json
    save
  end  
end