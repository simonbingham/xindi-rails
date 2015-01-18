class Admin::EnquiriesController < Admin::BaseController

  # GET /admin/enquiries
  def index
    @page_title = 'Enquiries'
    @enquiries = Enquiry.order('created_at DESC')
  end

  # GET /admin/enquiries/:id
  def show
    @enquiry = Enquiry.find(params[:id])
    @page_title = @enquiry.name
  end

  # DELETE /admin/enquiries/:id
  def destroy
    @enquiry = Enquiry.find(params[:id])
    @enquiry.destroy
    flash[:success] = 'The enquiry was successfully deleted.'
    redirect_to admin_enquiries_path
  end

end
