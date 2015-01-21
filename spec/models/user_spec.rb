require 'rails_helper'

describe User do
  context 'when creating or updating' do
    it 'should pass validation when valid attributes' do
      expect(FactoryGirl.build(:user)).to be_valid
    end

    it 'should fail validation when email address is blank' do
      expect(FactoryGirl.build(:user, email_address: '')).to_not be_valid
    end

    it 'should fail validation when email address is invalid' do
      expect(FactoryGirl.build(:user, email_address: 'an invalid email address')).to_not be_valid
    end

    it 'should fail validation when email address is not unique' do
      FactoryGirl.create(:user)
      expect(FactoryGirl.build(:user, email_address: 'factory@getxindi.com')).to_not be_valid
    end

    it 'should fail validation when password does not match password confirmation' do
      expect(FactoryGirl.build(:user, :password => 'test password', :password_confirmation => '' )).to_not be_valid
    end

    it 'should fail validation when password and password confirmation are blank' do
      expect(FactoryGirl.build(:user, :password => '', :password_confirmation => '' )).to_not be_valid
    end
  end

end
