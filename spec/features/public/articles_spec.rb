require 'rails_helper'

feature 'articles' do
  before(:each) do
    FactoryGirl.create(:article)
  end

  it 'displays listing page' do
    visit public_articles_path
    expect(page).to have_content 'News'
    expect(page).to have_content 'the title'
    expect(page).to have_content 'the content'
  end

  it 'displays article page' do
    visit public_articles_path << '/the-title'
    expect(page).to have_content 'the content'
    expect(page).to have_content 'the author'
  end
end
