require 'rails_helper'

describe 'Routing' do
  it { expect(:get => '/search').to route_to(:controller => 'public/search', :action => 'index') }
end

describe Public::SearchController do
  describe 'GET #index' do
    subject { expect(get :index) }
    it { subject.to render_template(:index) }
    it { subject.to render_template(:layout => 'public') }
    it { subject.to have_http_status(200) }
  end
end
