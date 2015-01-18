require 'rails_helper'

describe User do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  it 'should fail validation when email address is invalid' do
    expect(User.new(:email_address => 'invalid email address', :password => 'test password', :password_confirmation => 'test password' )).to_not be_valid
  end

  it 'should fail validation when email address is not unique' do
    expect(User.new(:email_address => 'factory@getxindi.com', :password => 'test password', :password_confirmation => 'test password' )).to_not be_valid
  end

  it 'should fail validation when password does not match password confirmation' do
    expect(User.new(:email_address => 'admin@getxindi.com', :password => 'test password', :password_confirmation => '' )).to_not be_valid
  end

  it 'should fail validation when password and password confirmation are blank' do
    expect(User.new(:email_address => 'admin@getxindi.com', :password => '', :password_confirmation => '' )).to_not be_valid
  end

  it 'should pass validation when email address is unique and password matches password confirmation' do
    expect(User.new(:email_address => 'admin@getxindi.com', :password => 'test password', :password_confirmation => 'test password' )).to be_valid
  end

end
