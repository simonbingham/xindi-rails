require 'rails_helper'

feature 'page manager' do
  def create_page_helper
    visit admin_pages_path
    click_link('Add Page')
    fill_in('page_title', :with => 'the title')
    fill_in('page_content', :with => 'the content')
    click_button('Save Page')
  end

  def generate_siblings_helper
    root_page = FactoryGirl.create(:page)
    first_sibling_page = FactoryGirl.create(:page, ancestor_id: root_page.id)
    second_sibling_page = FactoryGirl.create(:page, ancestor_id: root_page.id)
    {first_sibling_page: first_sibling_page, second_sibling_page: second_sibling_page}
  end

  before(:each) do
    FactoryGirl.create(:page)
    FactoryGirl.create(:user)
    visit admin_login_path
    fill_in('email_address', :with => 'factory@example.com')
    fill_in('password', :with => 'password')
    click_button('Login')
  end

  it 'displays page listing' do
    visit admin_pages_path
    expect(page).to have_content 'Pages'
  end

  context 'when adding a page' do
    it 'adds page with valid attributes' do
      create_page_helper
      expect(page).to have_content 'The page was successfully created.'
    end

    it 'does not add page with invalid attributes' do
      visit admin_pages_path
      click_link('Add Page')
      click_button('Save Page')
      expect(page).to have_content 'Please amend the following 2 fields:'
    end
  end

  it 'edits page' do
    visit admin_pages_path
    click_link('Edit')
    fill_in('page_title', :with => 'the new title')
    click_button('Save Page')
    expect(page).to have_content 'The page was successfully updated.'
  end

  context 'when moving a page' do
    it 'moves page up' do
      generate_siblings_helper
      visit admin_pages_path
      click_link('Move Up', :match => :first)
      expect(page).to have_content 'The page has been moved up.'
    end

    it 'moves page down' do
      generate_siblings_helper
      visit admin_pages_path
      click_link('Move Down', :match => :first)
      expect(page).to have_content 'The page has been moved down.'
    end
  end

  it 'deletes page' do
    create_page_helper
    click_link('Delete')
    expect(page).to have_content 'The page was successfully deleted.'
  end
end
