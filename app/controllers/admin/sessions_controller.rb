class Admin::SessionsController < Admin::BaseController
  skip_before_action :authorize

  # GET /admin/login
  def new
    @page_title = 'Login'
  end

  # POST /admin/login
  def create
    user = User.find_by(email_address: params[:email_address])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_dashboard_path
    else
      flash[:danger] = 'The email address and password combination you entered was invalid.'
      redirect_to admin_login_path
    end
  end

  # DELETE /admin/logout
  def destroy
    @page_title = 'Logout'
    session[:user_id] = nil
    flash[:success] = 'You have been logged out.'
    redirect_to admin_dashboard_path
  end
end
