require 'rails_helper'

describe 'Routing' do
  it { expect(:get => '/news').to route_to(:controller => 'public/articles', :action => 'index') }
  it { expect(:get => '/news/slug').to route_to(:controller => 'public/articles', :action => 'show', :slug => 'slug') }
end

describe Public::ArticlesController do
  before(:each) do
    @article = FactoryGirl.create(:article)
  end

  describe 'GET #index' do
    subject { expect(get :index) }
    it { subject.to render_template('index') }
    it { subject.to render_template(:layout => 'public') }
    it { subject.to have_http_status(200) }
  end

  describe 'GET #show' do
    context 'when valid slug' do
      subject { expect(get :show, slug: 'the-title') }
      it { subject.to render_template('show') }
      it { subject.to render_template(:layout => 'public') }
      it { subject.to have_http_status(200) }
    end

    context 'when invalid slug' do
      subject { expect {get :show, slug: 'invalid-slug'} }
      it { subject.to raise_error ActiveRecord::RecordNotFound }
    end
  end
end
