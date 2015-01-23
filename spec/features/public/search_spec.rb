require 'rails_helper'

feature 'search form' do
  before(:each) do
    FactoryGirl.create(:page)
  end

  context 'when displaying results' do
    it 'displays results when matches exist' do
      visit root_path
      fill_in('search_term', :with => 'the title')
      click_button('Search')
      expect(page).to have_content 'There is 1 record matching the search term "the title".'
    end

    it 'displays message when no matches exist' do
      visit root_path
      fill_in('search_term', :with => 'nothing matches this')
      click_button('Search')
      expect(page).to have_content 'No records were found matching "nothing matches this".'
    end
  end
end
