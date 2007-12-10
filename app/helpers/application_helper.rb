# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include ActionView::Helpers::TagHelper
  
  def site
    @context['site']
  end
      
  ####################
  # URL Helpers
  
  def article_path(page)
    "/pages/#{page.id}"
  end
  
  def trackback_path(page)
    "/pages/#{page.id}/trackbacks"
  end
  
  def comments_path(page)
    "#{article_path(page)}/comments"
  end

  def trackback_url(page)
    "#{site.home_url}#{trackback_path(page)}"
  end
  
  def link_to_article(page)
    "<a href=\"#{article_path(page)}\">#{page.title}</a>"
  end
  
  def link_to_search_result(page)  
    link_to_article(page)
  end
  
  def linked_tag_list(page)
    page.tags
  end
  
  ####################
  # Markup Helpers
  
  def javascript(name)
    content_tag 'script', '', :src => site.theme.javascript_url(name), :language => 'javascript'
  end
  
  def stylesheet(name, media = nil)
    tag 'link', :rel => 'stylesheet', :type => 'text/css', :href => site.theme.stylesheet_url(name), :media => media
  end  
  
  def header(site)
    [generator, rss, pingback].join("\n")
  end
  
  def footer(site)
    [google_analytics, lemonpen, sytax_highlighter].join("\n")
  end
  
  def pagination(no)
    ret = ""
    ret << "<a href=\"?no=#{no+1}\"> <<  이전 글 </a>"
    
    if no > 1
      ret << " | "
      ret << "<a href=\"?no=#{no-1}\"> >> 다음 글 </a>"
    end
    
    ret
  end  
  
  def generator
    '<meta name="generator" content="Slugger" />'
  end
  
  def rss
    feed_path = site.feed_path
    feed_path = "#{site.home_url}/pages.atom"  if feed_path.blank?
    tag 'link', :rel => 'alternate', :type => 'application/atom+xml', :href => feed_path, :title => 'Articles for Home'
  end
  
  def pingback
    tag 'link', :rel => 'pingback', :href => "#{site.home_url}/xmlrpc"
  end
    
  def google_analytics
    return nil unless site.google_analytics
    
    <<-HTML
      <script src="http://www.google-analytics.com/urchin.js" type="text/javascript"></script>
      <script type="text/javascript">_uacct = "#{site.google_analytics}";urchinTracker();</script>
    HTML
  end
  
  def lemonpen
    return nil unless site.lemonpen_sid
    
    <<-HTML
      <script src="http://script.lemonpen.com/site/lemonpen.js?sid=#{site.lemonpen_sid}" type="text/javascript" charset="UTF-8"></script>
    HTML
  end
  
  def sytax_highlighter
    <<-HTML
      <link href="/stylesheets/highlight.css" rel="stylesheet" type="text/css" />
      <script language="javascript" src="/javascripts/highlight.js"></script>
      <script language="javascript">dp.SyntaxHighlighter.HighlightAll('code');</script>
    HTML
  end
end