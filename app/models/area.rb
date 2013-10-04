class Area < ActiveRecord::Base
  belongs_to :city
  belongs_to :bank_account
  attr_accessible :name, :city, :bank_account, :bank_account_id

  has_many :rates
  has_many :streets

  validates :city, :presence=>true
  validates :bank_account, :presence=>true
end
