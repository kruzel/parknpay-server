class PaymentCalculation
  def calculate (payment)
    @rates = Rate.where("area_id = ? and ((valid_start_at <= ? and valid_end_at >= ?) or (valid_start_at <= ? and valid_end_at >= ?)) and ((start_day_a_week >= ? and end_day_a_week <= ?) or (start_day_a_week >= ? and end_day_a_week <= ?)) and ((start_time <=  ? and end_time >= ?) or (start_time <=  ? and end_time >= ?))",
                       payment.area_id, payment.start_time, payment.start_time, payment.end_time, payment.end_time, payment.start_time.wday, payment.start_time.wday, payment.end_time.wday, payment.end_time.wday, payment.start_time.hour, payment.start_time.hour, payment.end_time.hour, payment.end_time.hour)

    sum = 0;

    #for each payment day from start to end
    (payment.start_time.change(:hour => 0)..payment.end_time.change(:hour => 0)).step(1.day).each do |day|
      #find rates that are valid and have overlapping days
      valid_rates = get_valid_rates_for_day(day)
      #for each rate during that day
      valid_rates.each do |rate|
        #  if rate hours overlap with payment hours

        #    sum += overlapping period of time * rate

      end
    end
  end

  def get_valid_rates_for_day (payment_day)
    valid_rates = Array.new
    @rates.each do |rate|
      if payment_day >= rate.valid_start_at.change(:hour => 0) && payment_day <= rate.valid_end_at.change(:hour => 0)
        valid_rates.push(rate)
      end
    end
    return valid_rates
  end

end