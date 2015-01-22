require 'rails_helper'

describe 'Routing' do
  it { expect(:get => '/admin/pages').to route_to(:controller => 'admin/pages', :action => 'index') }
  it { expect(:get => '/admin/pages/new/1').to route_to(:controller => 'admin/pages', :action => 'new', :ancestor_id => '1') }
  it { expect(:get => '/admin/pages/1/edit').to route_to(:controller => 'admin/pages', :action => 'edit', :id => '1') }
  it { expect(:post => '/admin/pages').to route_to(:controller => 'admin/pages', :action => 'create') }
  it { expect(:patch => '/admin/pages/1').to route_to(:controller => 'admin/pages', :action => 'update', :id => '1') }
  it { expect(:delete => '/admin/pages/1').to route_to(:controller => 'admin/pages', :action => 'destroy', :id => '1') }
end

describe Admin::PagesController do
  before(:each) do
    @page = FactoryGirl.create(:page)
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
    subject { expect(get :new, ancestor_id: 1) }
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
      subject { expect(post :create, page: FactoryGirl.attributes_for(:page)) }
      it { subject.to redirect_to(admin_pages_path) }
      it { subject.to have_http_status(302) }
    end

    context 'when invalid attributes' do
      subject { expect(post :create, page: FactoryGirl.attributes_for(:page, title: '')) }
      it { subject.to render_template(:maintain) }
      it { subject.to render_template(:layout => 'admin') }
      it { subject.to have_http_status(200) }
    end
  end

  describe 'PATCH #update' do
    context 'when valid attributes' do
      subject { expect(put :update, id: 1, page: FactoryGirl.attributes_for(:page)) }
      it { subject.to redirect_to(admin_pages_path) }
      it { subject.to have_http_status(302) }
    end

    context 'when invalid attributes' do
      subject { expect(put :update, id: 1, page: FactoryGirl.attributes_for(:page, title: '')) }
      it { subject.to render_template(:maintain) }
      it { subject.to render_template(:layout => 'admin') }
      it { subject.to have_http_status(200) }
    end
  end

  describe 'DELETE #destroy' do
    subject { expect(delete :destroy, id: 1) }
    it { subject.to redirect_to(admin_pages_path) }
    it { subject.to have_http_status(302) }
  end

  describe 'GET #move' do
    subject { expect(get :move, id: 1) }
     it { subject.to redirect_to(admin_pages_path) }
    it { subject.to have_http_status(302) }
  end
end
