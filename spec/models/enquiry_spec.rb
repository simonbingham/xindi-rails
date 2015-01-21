require 'rails_helper'

describe Enquiry do
  context 'when creating' do
    it 'should pass validation when valid attributes' do
      expect(FactoryGirl.build(:enquiry)).to be_valid
    end

    it 'should fail validation when name is blank' do
      expect(FactoryGirl.build(:enquiry, name: '')).to_not be_valid
    end

    it 'should fail validation when email address is blank' do
      expect(FactoryGirl.build(:enquiry, email_address: '')).to_not be_valid
    end

    it 'should fail validation when email address is invalid' do
      expect(FactoryGirl.build(:enquiry, email_address: 'an invalid email address')).to_not be_valid
    end

    it 'should fail validation when message is blank' do
      expect(FactoryGirl.build(:enquiry, message: '')).to_not be_valid
    end
  end
end
