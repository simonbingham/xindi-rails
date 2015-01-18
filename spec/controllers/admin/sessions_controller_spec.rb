require 'rails_helper'

describe 'Routing' do
  it { expect(:get => '/admin/login').to route_to(:controller => 'admin/sessions', :action => 'new') }
  it { expect(:post => '/admin/login').to route_to(:controller => 'admin/sessions', :action => 'create') }
  it { expect(:delete => '/admin/logout').to route_to(:controller => 'admin/sessions', :action => 'destroy') }
end

describe Admin::SessionsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  describe 'GET #new' do
    subject { expect(get :new) }
    it { subject.to render_template(:new) }
    it { subject.to render_template(:layout => 'admin') }
    it { subject.to have_http_status(200) }
  end

  describe 'POST #create' do
    context 'when valid attributes' do
      subject { expect(post :create, email_address: 'factory@getxindi.com', password: 'password') }
      it { subject.to redirect_to(admin_dashboard_path) }
    end

    context 'when invalid attributes' do
      subject { expect(post :create) }
      it { subject.to redirect_to(admin_login_path) }
    end
  end

  describe 'DELETE #destroy' do
    subject { expect(delete :destroy) }
    it { subject.to redirect_to(admin_dashboard_path) }
    it { subject.to have_http_status(302) }
  end
end
