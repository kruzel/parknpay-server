class Payment < ActiveRecord::Base
  belongs_to :street
  belongs_to :area
  belongs_to :city
  belongs_to :creditor
  belongs_to :rate
  belongs_to :user
  attr_accessible :end_time, :start_time, :x_pos, :y_pos, :creditor, :street, :area, :city, :rate, :user
end
