class Admin::ArticlesController < Admin::BaseController
  before_action :set_article, only: [:edit, :update, :destroy]

  # GET /admin/articles
  def index
    @page_title = 'News'
    @articles = Article.order('created_at DESC')
  end

  # GET /admin/articles/new
  def new
    @page_title = 'Add Article'
    @article = Article.new
    @action = 'create'
    render :template => 'admin/articles/maintain'
  end

  # GET /admin/articles/:id/edit
  def edit
    @page_title = 'Edit Article'
    @action = 'update'
    render :template => 'admin/articles/maintain'
  end

  # POST /admin/articles
  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:success] = 'The article was successfully created.'
      redirect_to admin_articles_path
    else
      @page_title = 'Add Article'
      render action: 'maintain'
    end
  end

  # PATCH /admin/articles/:id
  def update
    if @article.update(article_params)
      flash[:success] = 'The article was successfully updated.'
      redirect_to admin_articles_path
    else
      @page_title = 'Edit Article'
      render action: 'maintain'
    end
  end

  # DELETE /admin/articles/:id
  def destroy
    @article.destroy
    flash[:success] = 'The article was successfully deleted.'
    redirect_to admin_articles_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:slug, :title, :content, :meta_generated, :meta_title, :meta_description, :meta_keywords, :author, :bootsy_image_gallery_id)
    end
end
