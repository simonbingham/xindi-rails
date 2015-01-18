class Admin::BaseController < ApplicationController
  before_action :authorize, :except => '/admin/pages#save_sort'

  layout 'admin'

  protected

  def authorize
    if request.format == Mime::HTML
      unless User.find_by(id: session[:user_id])
        redirect_to admin_login_path
      end
    else
      authenticate_or_request_with_http_basic do |username, password|
        user = User.find_by(name: username)
        user && user.authenticate(password)
      end
    end
  end
end
