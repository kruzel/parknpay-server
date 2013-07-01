class Creditor < ActiveRecord::Base
  attr_accessible :bank_account, :bank_code, :bank_name, :bank_office, :contact_email, :contact_name, :contact_phone, :name

  has_many :areas
end
