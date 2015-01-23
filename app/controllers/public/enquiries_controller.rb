class Public::EnquiriesController < Public::BaseController

  # GET /contact
  def index
    @page_title = 'Contact Us'
    @enquiry = Enquiry.new
    @meta_data = {
      :meta_title => @page_title << ' | ' << Rails.configuration.site[:name],
      :meta_description => '',
      :meta_keywords => ''
    }
  end

  # POST /contact
  def create
    @enquiry = Enquiry.new(enquiry_params)
    if @enquiry.save
      EnquiryNotifier.received(@enquiry).deliver
      flash[:success] = 'Your enquiry has been received.'
      redirect_to public_enquiries_path
    else
      @page_title = 'Contact Us'
      render :template => 'public/enquiries/index'
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def enquiry_params
      params.require(:enquiry).permit(:name, :email_address, :message)
    end

end
