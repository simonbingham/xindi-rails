class Enquiry < ActiveRecord::Base
  validates :name, :email_address, :message, presence: true
  validates_format_of :email_address, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
