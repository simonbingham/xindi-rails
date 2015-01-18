atom_feed do |feed|
  feed.title(Rails.configuration.articles[:rss_feed_title])
  feed.updated(@articles.first.created_at)

  @articles.each do |article|
    feed.entry(article, :url => article.get_url(public_articles_url)) do |entry|
      entry.title(article.title)
      entry.content(article.content, type: 'html')
      entry.author(article.author)
    end
  end
end
