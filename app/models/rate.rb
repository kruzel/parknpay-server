class Rate < ActiveRecord::Base
  belongs_to :area
  attr_accessible :currency, :end_time, :rate, :start_time, :area
end
