class Public::PagesController < Public::BaseController

  def index
    if params.has_key?(:slug)
      slug = params[:slug]
      if params.has_key?(:child_slug)
        slug << "/" << params[:child_slug]
      end
      @page = Page.find_by! slug: slug
    else
      @page = Page.find_by! left_value: 1
    end
    @meta_data = {
      :meta_title => @page.meta_title,
      :meta_description => @page.meta_description,
      :meta_keywords => @page.meta_keywords
    }
  end

end
