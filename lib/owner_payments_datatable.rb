class OwnerPaymentsDatatable
  delegate :params, :link_to, :edit_payment_path, :current_user, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Payment.count,
        iTotalDisplayRecords: payments.total_entries,
        aaData: data
    }
  end

  private

  def data
    payments.map do |payment|
      [
          payment.car.car_description,
          payment.area.city.name,
          payment.area.name,
          payment.user.firstname + ' ' + payment.user.lastname,
          payment.start_time,
          payment.end_time,
          link_to('Show', payment),
          link_to('Edit', edit_payment_path(payment)),
          link_to('Destroy', payment, method: :delete, data: { confirm: 'Are you sure?' })
      ]
    end
  end

  def payments
    @payments ||= fetch_payments
  end

  def fetch_payments
    if current_user.role == 'owner' && current_user.bank_account
      areas = Area.where("bank_account_id = ?",current_user.bank_account_id)
      areas.each do |area|
        @owner_payments = Payment.paginate(:page => params[:page], :per_page => 20).where("area_id = ?", area.id)
      end

      if @owner_payments
        @owner_payments = @owner_payments.order("#{sort_column} #{sort_direction}")
        @owner_payments = @owner_payments.page(page).per_page(per_page)
        if params[:sSearch].present?
          @owner_payments = @owner_payments.where("name like :search or category like :search", search: "%#{params[:sSearch]}%")
        end
      end
    end

    @owner_payments
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[car_id area_id area_id]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

end