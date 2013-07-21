class Rate < ActiveRecord::Base
  belongs_to :area
  attr_accessible :currency, :end_time, :rate, :start_time, :area, :day_a_week

  def get_start_time
    start_time.strftime('%H%M')
  end

  def get_end_time
    end_time.strftime('%H%M')
  end

end
