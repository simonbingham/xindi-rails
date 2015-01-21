require 'rails_helper'

describe 'Routing' do
  it { expect(:get => '/admin/articles').to route_to(:controller => 'admin/articles', :action => 'index') }
  it { expect(:get => '/admin/articles/new').to route_to(:controller => 'admin/articles', :action => 'new') }
  it { expect(:get => '/admin/articles/1/edit').to route_to(:controller => 'admin/articles', :action => 'edit', :id => '1') }
  it { expect(:post => '/admin/articles').to route_to(:controller => 'admin/articles', :action => 'create') }
  it { expect(:patch => '/admin/articles/1').to route_to(:controller => 'admin/articles', :action => 'update', :id => '1') }
  it { expect(:delete => '/admin/articles/1').to route_to(:controller => 'admin/articles', :action => 'destroy', :id => '1') }
end

describe Admin::ArticlesController do
  before(:each) do
    @article = FactoryGirl.create(:article)
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
      subject { expect(post :create, article: FactoryGirl.attributes_for(:article, title: 'a title', content: 'some content', author: 'an author')) }
      it { subject.to redirect_to(admin_articles_path) }
      it { subject.to have_http_status(302) }
    end

    context 'when invalid attributes' do
      subject { expect(post :create, article: FactoryGirl.attributes_for(:article)) }
      it { subject.to render_template(:maintain) }
      it { subject.to render_template(:layout => 'admin') }
      it { subject.to have_http_status(200) }
    end
  end

  describe 'POST #update' do
    context 'when valid attributes' do
      subject { expect(put :update, id: 1, article: FactoryGirl.attributes_for(:article)) }
      it { subject.to redirect_to(admin_articles_path) }
      it { subject.to have_http_status(302) }
    end

    context 'when invalid attributes' do
      subject { expect(put :update, id: 1, article: FactoryGirl.attributes_for(:article, title: '')) }
      it { subject.to render_template(:maintain) }
      it { subject.to render_template(:layout => 'admin') }
      it { subject.to have_http_status(200) }
    end
  end

  describe 'DELETE #destroy' do
    subject { expect(delete :destroy, id: 1) }
    it { subject.to redirect_to(admin_articles_path) }
    it { subject.to have_http_status(302) }
  end
end
