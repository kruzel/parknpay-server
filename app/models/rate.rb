class Rate < ActiveRecord::Base
  belongs_to :area
  attr_accessible :currency, :end_time, :rate, :start_time, :area, :start_day_a_week, :end_day_a_week

  def start_time_int
    start_time.strftime('%H%M').to_i
  end

  def end_time_int
    end_time.strftime('%H%M').to_i
  end

end
