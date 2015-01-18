require 'rails_helper'

describe 'Routing' do
  it { expect(:get => '/contact').to route_to(:controller => 'public/enquiries', :action => 'index') }
  it { expect(:post => '/contact').to route_to(:controller => 'public/enquiries', :action => 'create') }
end

describe Public::EnquiriesController do
  before(:each) do
    @article = FactoryGirl.create(:article)
  end

  describe 'GET #index' do
    subject { expect(get :index) }
    it { subject.to render_template('index') }
    it { subject.to render_template(:layout => 'public') }
    it { subject.to have_http_status(200) }
  end

  describe 'POST #create' do
    context 'when valid attributes' do
      subject { expect(post :create, enquiry: FactoryGirl.attributes_for(:enquiry, name: 'the name', email_address: 'test@getxindi.com', message: 'the message')) }
      it { subject.to redirect_to(public_enquiries_path) }
      it { subject.to have_http_status(302) }
    end

    context 'when invalid attributes' do
      subject { expect(post :create, enquiry: FactoryGirl.attributes_for(:enquiry, name: '', email_address: '', message: '')) }
      it { subject.to render_template('index') }
      it { subject.to render_template(:layout => 'public') }
      it { subject.to have_http_status(200) }
    end
  end
end
