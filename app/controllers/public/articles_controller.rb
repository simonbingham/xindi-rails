class Public::ArticlesController < Public::BaseController
  before_action :set_article, only: [:edit, :update, :destroy]

  # GET /news or /news.atom
  def index
    @page_title = 'News'
    @articles = Article.order('created_at DESC')
    respond_to do |format|
      format.html {
        @meta_data = {
          :meta_title => @page_title,
          :meta_description => '',
          :meta_keywords => ''
        }
      }
      format.atom
    end
  end

  # GET /news/:slug
  def show
    @article = Article.find_by! slug: params[:slug]
    @page_title = @article.title
    @meta_data = {
      :meta_title => @article.meta_title,
      :meta_description => @article.meta_description,
      :meta_keywords => @article.meta_keywords,
      :meta_author => @article.author
    }
  end
end
