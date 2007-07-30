module PagesHelper
  def page_title
    @page ? @page.title : ""
  end
  
  def header_title
    [page_title, Site.site_title].reject{|s| s.blank?}.join(' - ')
  end
    
  def side_content
    Page.side.content
  end  
end
