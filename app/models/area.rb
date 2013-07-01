class Area < ActiveRecord::Base
  belongs_to :city
  belongs_to :creditor
  attr_accessible :name, :city, :creditor, :creditor_id

  has_many :rates
end
