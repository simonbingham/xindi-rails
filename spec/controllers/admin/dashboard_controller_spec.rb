require 'rails_helper'

describe 'Routing' do
  it { expect(:get => '/admin').to route_to(:controller => 'admin/dashboard', :action => 'index') }
end

describe Admin::DashboardController do
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
end
