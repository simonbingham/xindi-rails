require 'rails_helper'

feature 'enquiry manager' do
  before(:each) do
    FactoryGirl.create(:user)
    visit admin_login_path
    fill_in('email_address', :with => 'factory@example.com')
    fill_in('password', :with => 'password')
    click_button('Login')
  end

  it 'displays enquiry listing' do
    visit admin_enquiries_path
    expect(page).to have_content 'There are currently no enquiries.'
  end

  it 'shows enquiry' do
    FactoryGirl.create(:enquiry)
    visit admin_enquiries_path
    click_link('Show Message')
    expect(page).to have_content 'the name'
    expect(page).to have_content 'factory@example.com'
    expect(page).to have_content 'the message'
  end

  it 'deletes enquiry' do
    FactoryGirl.create(:enquiry)
    visit admin_enquiries_path
    click_link('Delete')
    expect(page).to have_content 'The enquiry was successfully deleted.'
  end
end
