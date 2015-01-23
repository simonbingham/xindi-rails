require 'rails_helper'

feature 'session manager' do
  def login_user
    FactoryGirl.create(:user)
    visit admin_login_path
    fill_in('email_address', :with => 'factory@getxindi.com')
    fill_in('password', :with => 'password')
    click_button('Login')
  end

  context 'when logging in' do
    it 'logs in user with valid attributes' do
      login_user
      expect(page).to have_content 'Dashboard'
      expect(page).to have_content 'Please use the options above to maintain your site.'
    end

    it 'does not log in user with invalid credentials' do
      visit admin_login_path
      click_button('Login')
      expect(page).to have_content 'The email address and password combination you entered was invalid.'
    end
  end

  it 'logs out user' do
    login_user
    click_link('Logout')
    expect(page).to have_content 'You have been logged out.'
  end
end
