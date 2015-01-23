require 'rails_helper'

feature 'enquiries' do
  it 'displays enquiry form' do
    visit public_enquiries_path
    expect(page).to have_content 'Contact Us'
  end

  it 'displays confirmation message when form submitted with valid attributes' do
    visit public_enquiries_path
    fill_in('enquiry_name', :with => 'the name')
    fill_in('enquiry_email_address', :with => 'test@getxindi.com')
    fill_in('enquiry_message', :with => 'the message')
    click_button('Send')
    expect(page).to have_content 'Your enquiry has been received.'
  end
end
