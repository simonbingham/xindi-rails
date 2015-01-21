require 'rails_helper'

describe 'Routing' do
  it { expect(:get => '/slug').to route_to(:controller => 'public/pages', :action => 'index', :slug => 'slug') }
  it { expect(:get => '/slug/child_slug').to route_to(:controller => 'public/pages', :action => 'index', :slug => 'slug', :child_slug => 'child_slug') }
end

describe Public::PagesController do
  before(:each) do
    @page = FactoryGirl.create(:page)
  end

  describe 'GET #index' do
    subject { expect(get :index) }
    it { subject.to render_template(:index) }
    it { subject.to render_template(:layout => 'public') }
    it { subject.to have_http_status(200) }
  end
end
