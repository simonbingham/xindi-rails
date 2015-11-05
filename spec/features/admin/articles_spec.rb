require 'rails_helper'

feature 'article manager' do
  before(:each) do
    FactoryGirl.create(:user)
    visit admin_login_path
    fill_in('email_address', :with => 'factory@example.com')
    fill_in('password', :with => 'password')
    click_button('Login')
  end

  it 'displays article listing' do
    visit admin_articles_path
    expect(page).to have_content 'There are currently no news stories.'
  end

  context 'when adding an article' do
    it 'adds article with valid attributes' do
      visit admin_articles_path
      click_link('Add Article')
      fill_in('article_title', :with => 'the title')
      fill_in('article_content', :with => 'the content')
      fill_in('article_author', :with => 'the author')
      click_button('Create Article')
      expect(page).to have_content 'The article was successfully created.'
    end

    it 'does not add article with invalid attributes' do
      visit admin_articles_path
      click_link('Add Article')
      click_button('Create Article')
      expect(page).to have_content 'Please amend the following 3 fields:'
    end
  end

  it 'edits article' do
    FactoryGirl.create(:article)
    visit admin_articles_path
    click_link('Edit')
    fill_in('article_title', :with => 'the new title')
    click_button('Update Article')
    expect(page).to have_content 'The article was successfully updated.'
  end

  it 'deletes article' do
    FactoryGirl.create(:article)
    visit admin_articles_path
    click_link('Delete')
    expect(page).to have_content 'The article was successfully deleted.'
  end
end
