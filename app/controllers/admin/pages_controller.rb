class Admin::PagesController < Admin::BaseController
  before_action :set_page, only: [:edit, :update, :destroy, :sort]
  respond_to :json

  # GET /admin/pages
  def index
    @page_title = 'Pages'
    if params.has_key?(:sort_order_saved)
      flash[:success] = 'The page sort order was successfully updated.'
    end
    @pages = Page.order('left_value')
  end

  # GET /admin/pages/new
  def new
    @page_title = 'Add Page'
    @page = Page.new
    @page.ancestor_id = params[:ancestor_id]
    @action = 'create'
    render :template => 'admin/pages/maintain'
  end

  # GET /admin/pages/:id/edit
  def edit
    @page_title = 'Edit Page'
    @action = 'update'
    render :template => 'admin/pages/maintain'
  end

  # POST /admin/pages
  def create
    @page = Page.new(page_params)

    if @page.save
      flash[:success] = 'The page was successfully created.'
      redirect_to admin_pages_path
    else
      @page_title = 'Add Page'
      render action: 'maintain'
    end
  end

  # PATCH /admin/pages/:id
  def update
    if @page.update(page_params)
      flash[:success] = 'The page was successfully updated.'
      redirect_to admin_pages_path
    else
      @page_title = 'Edit Page'
      render action: 'maintain'
    end
  end

  # DELETE /admin/pages/:id
  def destroy
    @page.destroy
    flash[:success] = 'The page was successfully deleted.'
    redirect_to admin_pages_path
  end

  # GET /admin/pages/move
  def move
    if params[:direction] == 'up' || params[:direction] == 'down'
      @page = Page.find(params[:id])
      @page.move(params[:direction])
      flash[:success] = "The page has been moved #{params[:direction]}."
    end
    redirect_to admin_pages_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:slug, :ancestor_id, :title, :content, :meta_generated, :meta_title, :meta_description, :meta_keywords, :author, :bootsy_image_gallery_id)
    end
end
