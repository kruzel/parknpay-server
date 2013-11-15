class AreaRatesDatatable
  delegate :params, :link_to, :current_user, to: :@view

  def initialize(view, area)
    @view = view
    @area = area
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: rates.size,
        iTotalDisplayRecords: rates.size,
        aaData: data
    }
  end

  private

  def data
    rates.map do |rate|
      [
          rate.rate,
          rate.currency,
          rate.start_day_a_week,
          rate.end_day_a_week,
          rate.start_time, #:format =>  "%H:%M"
          rate.end_time, #, :format =>  "%H:%M"
          rate.valid_start_at,
          rate.valid_end_at,
          #link_to('Show', rate),
          #link_to('Edit', edit_rate_path(rate)),
          #link_to('Destroy', rate, method: :delete, data: { confirm: 'Are you sure?' })
      ]
    end
  end

  def rates
    @rates ||= fetch_rates
  end

  def fetch_rates
    tmp_rates = @area.rates

    tmp_rates
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[rate currency start_day_a_week end_day_a_week ]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

end