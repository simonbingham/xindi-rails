require 'rails_helper'

feature 'navigating pages' do
  before(:each) do
    root_page = FactoryGirl.create(:page, title: 'the home page title')
    parent_page = FactoryGirl.create(:page, ancestor_id: root_page.id, title: 'the parent page title')
    child_page = FactoryGirl.create(:page, ancestor_id: parent_page.id, title: 'the child page title')
  end

  it 'displays home page' do
    visit root_path
    expect(page).to have_content 'the home page title'
  end

  it 'displays parent page' do
    visit '/the-parent-page-title'
    expect(page).to have_content 'the parent page title'
  end

  it 'displays child page' do
    visit '/the-parent-page-title/the-child-page-title'
    expect(page).to have_content 'the child page title'
  end
end
