class Public::SearchController < Public::BaseController

  def index
    @page_title = 'Search Results'
    @meta_data = {
      :meta_title => @page_title << ' | ' << Rails.configuration.site[:name],
      :meta_description => '',
      :meta_keywords => ''
    }
    if params.has_key?('search_term') && params['search_term'].length > 0
      @words = params['search_term'].split(' ')
      matched_pages = Page.select(:title, :slug, :created_at, :content)
      matched_articles = Article.select(:title, :slug, :created_at, :content)
      @words.each do |word|
        matched_pages = matched_pages.where(["title LIKE :word OR content LIKE :word", {word: "%#{word}%"}])
        matched_articles = matched_articles.where(["title LIKE :word OR content LIKE :word", {word: "%#{word}%"}])
      end
      @search_results = matched_pages + matched_articles
    end
  end

end
