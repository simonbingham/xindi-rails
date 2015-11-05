require 'rails_helper'

feature 'user manager' do
  before(:each) do
    FactoryGirl.create(:user)
    visit admin_login_path
    fill_in('email_address', :with => 'factory@example.com')
    fill_in('password', :with => 'password')
    click_button('Login')
  end

  it 'displays user listing' do
    visit admin_users_path
    expect(page).to have_content 'Add User'
  end

  context 'when adding a user' do
    it 'adds user with valid attributes' do
      visit admin_users_path
      click_link('Add User')
      fill_in('user_email_address', :with => 'test@example.com')
      fill_in('user_password', :with => 'the password')
      fill_in('user_password_confirmation', :with => 'the password')
      click_button('Save User')
      expect(page).to have_content 'The user was successfully created.'
    end

    it 'does not add user with invalid attributes' do
      visit admin_users_path
      click_link('Add User')
      click_button('Save User')
      expect(page).to have_content 'Please amend the following 3 fields:'
    end
  end

  it 'edits user' do
    visit admin_users_path
    click_link('Edit')
    fill_in('user_password', :with => 'the new password')
    fill_in('user_password_confirmation', :with => 'the new password')
    click_button('Save User')
    expect(page).to have_content 'The user was successfully updated.'
  end

  context 'when deleting a user' do
    it 'deletes user when more than one remains' do
      FactoryGirl.create(:user, email_address: 'delete@example.com')
      visit admin_users_path
      click_link('Delete', :match => :first)
      expect(page).to have_content "The user was successfully deleted."
    end

    it 'does not delete user when only one remains' do
      visit admin_users_path
      click_link('Delete')
      expect(page).to have_content "Can't delete last user"
    end
  end
end
