class Admin::DashboardController < Admin::BaseController
  layout 'admin'

  def index
    @page_title = 'Dashboard'
  end
end
