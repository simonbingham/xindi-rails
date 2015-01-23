require 'rails_helper'

feature 'dashboard' do
  it 'displays dashboard' do
    FactoryGirl.create(:user)
    visit admin_login_path
    fill_in('email_address', :with => 'factory@getxindi.com')
    fill_in('password', :with => 'password')
    click_button('Login')
    expect(page).to have_content 'Dashboard'
    expect(page).to have_content 'Please use the options above to maintain your site.'
  end
end
