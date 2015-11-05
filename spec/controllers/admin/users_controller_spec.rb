require 'rails_helper'

describe 'Routing' do
  it { expect(:get => '/admin/users').to route_to(:controller => 'admin/users', :action => 'index') }
  it { expect(:get => '/admin/users/new').to route_to(:controller => 'admin/users', :action => 'new') }
  it { expect(:get => '/admin/users/1/edit').to route_to(:controller => 'admin/users', :action => 'edit', :id => '1') }
  it { expect(:post => '/admin/users').to route_to(:controller => 'admin/users', :action => 'create') }
  it { expect(:patch => '/admin/users/1').to route_to(:controller => 'admin/users', :action => 'update', :id => '1') }
  it { expect(:delete => '/admin/users/1').to route_to(:controller => 'admin/users', :action => 'destroy', :id => '1') }
end

describe Admin::UsersController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    session[:user_id] = @user.id
  end

  after(:each) do
    session[:user_id] = nil
  end

  describe 'GET #index' do
    subject { expect(get :index) }
    it { subject.to render_template(:index) }
    it { subject.to render_template(:layout => 'admin') }
    it { subject.to have_http_status(200) }
  end

  describe 'GET #new' do
    subject { expect(get :new) }
    it { subject.to render_template(:maintain) }
    it { subject.to render_template(:layout => 'admin') }
    it { subject.to have_http_status(200) }
  end

  describe 'GET #edit' do
    subject { expect(get :edit, id: 1) }
    it { subject.to render_template(:maintain) }
    it { subject.to render_template(:layout => 'admin') }
    it { subject.to have_http_status(200) }
  end

  describe 'POST #create' do
    context 'when valid attributes' do
      subject { expect(post :create, user: FactoryGirl.attributes_for(:user, email_address: 'test@example.com', password: 'password', password_confirmation: 'password')) }
      it { subject.to redirect_to(admin_users_path) }
      it { subject.to have_http_status(302) }
    end

    context 'when invalid attributes' do
      subject { expect(post :create, user: FactoryGirl.attributes_for(:user)) }
      it { subject.to render_template(:maintain) }
      it { subject.to render_template(:layout => 'admin') }
      it { subject.to have_http_status(200) }
    end
  end

  describe 'POST #update' do
    context 'when valid attributes' do
      subject { expect(put :update, id: 1, user: FactoryGirl.attributes_for(:user)) }
      it { subject.to redirect_to(admin_users_path) }
      it { subject.to have_http_status(302) }
    end

    context 'when invalid attributes' do
      subject { expect(put :update, id: 1, user: FactoryGirl.attributes_for(:user, email_address: 'invalid_email_address')) }
      it { subject.to render_template(:maintain) }
      it { subject.to render_template(:layout => 'admin') }
      it { subject.to have_http_status(200) }
    end
  end

  describe 'DELETE #destroy' do
    subject { expect(delete :destroy, id: 1) }
    it { subject.to redirect_to(admin_users_path) }
    it { subject.to have_http_status(302) }
  end
end
