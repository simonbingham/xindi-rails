class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:edit, :update, :destroy]

  # GET /admin/users
  def index
    @page_title = 'Users'
    @users = User.order('created_at DESC')
  end

  # GET /admin/users/new
  def new
    @page_title = 'Add User'
    @user = User.new
    @action = 'create'
    render :template => 'admin/users/maintain'
  end

  # GET /admin/users/:id/edit
  def edit
    @page_title = 'Edit User'
    @action = 'update'
    render :template => 'admin/users/maintain'
  end

  # POST /admin/users
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'The user was successfully created.'
      redirect_to admin_users_path
    else
      @page_title = 'Add User'
      render action: 'maintain'
    end
  end

  # PATCH /admin/users/:id
  def update
    if @user.update(user_params)
      flash[:success] = 'The user was successfully updated.'
      redirect_to admin_users_path
    else
      @page_title = 'Edit User'
      render action: 'maintain'
    end
  end

  # DELETE /admin/users/:id
  def destroy
    begin
      @user.destroy
      flash[:success] = 'The user was successfully deleted.'
    rescue StandardError => e
      flash[:danger] = e.message
    end
    redirect_to admin_users_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email_address, :password, :password_confirmation)
    end
end
