require 'rails_helper'

describe 'Routing' do
  it { expect(:get => '/admin/enquiries').to route_to(:controller => 'admin/enquiries', :action => 'index') }
  it { expect(:get => '/admin/enquiries/1').to route_to(:controller => 'admin/enquiries', :action => 'show', :id => '1') }
end

describe Admin::EnquiriesController do
  before(:each) do
    @enquiry = FactoryGirl.create(:enquiry)
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

  describe 'GET #show' do
    subject { expect(get :show, id: 1) }
    it { subject.to render_template(:show) }
    it { subject.to render_template(:layout => 'admin') }
    it { subject.to have_http_status(200) }
  end

  describe 'DELETE #destroy' do
    subject { expect(delete :destroy, id: 1) }
    it { subject.to redirect_to(admin_enquiries_path) }
    it { subject.to have_http_status(302) }
  end
end
