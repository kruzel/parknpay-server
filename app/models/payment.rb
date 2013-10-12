class Payment < ActiveRecord::Base
  belongs_to :area
  belongs_to :rate
  belongs_to :user
  belongs_to :car
  attr_accessible :end_time, :start_time, :x_pos, :y_pos, :area, :user, :area_id, :user_id, :car, :car_id, :amount

  validates :user, :presence=>true
  validates :area, :presence=>true
  validates :car, :presence => true
end
