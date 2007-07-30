atom_feed(:root_url => Site.home_url, :url => formatted_pages_url(:atom)) do |feed|
  feed.title(Site.site_title)
  feed.updated(@pages.first ? @pages.first.date_created : Time.now.utc)

  @pages.each do |page|
    feed.entry(page) do |entry|
      entry.title(page.title)
      entry.content(page.content, :type => 'html')

      entry.author {|author| author.name(page.creator) }
    end # feed
  end # pages
end # atom
