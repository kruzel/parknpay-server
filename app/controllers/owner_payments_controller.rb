class OwnerPaymentsController < PaymentsController

  require './lib/owner_payments_datatable.rb'

  before_filter :authenticate_user!
  layout 'owner'

  # GET /payments/owner_paymenta
  # GET /payments/owner_paymenta.json
  def owners_payments
    authorize! :owners_payments, :owner_payments

    if current_user.role == 'owner' && current_user.bank_account
      @payments = OwnerPaymentsDatatable.new(view_context)

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @payments }
      end
    else
      #error page
      respond_to do |format|
        format.html # owner_payments.html.erb
        format.json { render json: @payments }
      end
    end
  end
end
