class OwnerPaymentsController < PaymentsController

  layout 'owner'

  # GET /payments/owner_paymenta
  # GET /payments/owner_paymenta.json
  def owners_payments
    authorize! :owners_payments, :owner_payments

    if current_user.role == 'owner' && current_user.bank_account
      @areas = Area.find(currenet_user.bankk_account.id)
      @payments = Payment.where("area_id = ?", current_user.id)

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @payments }
      end
    else
      #error page
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @payments }
      end
    end
  end
end
