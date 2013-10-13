class PaymentsController < ApplicationController
  
    before_filter :authenticate_user!
    load_and_authorize_resource
    layout 'admin' #( current_user.role == 'user' ? 'admin' : 'owner' )
  
  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payments }
    end
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
    @payment = Payment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment }
    end
  end

  # GET /payments/new
  # GET /payments/new.json
  def new
    @payment = Payment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @payment }
    end
  end

  # GET /payments/1/edit
  def edit
    @payment = Payment.find(params[:id])
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(params[:payment])

    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
        format.json { render json: @payment, status: :created, location: @payment }
      else
        format.html { render action: "new" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /payments/1
  # PUT /payments/1.json
  def update
    @payment = Payment.find(params[:id])

    respond_to do |format|
      if @payment.update_attributes(params[:payment])
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
=begin
  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to payments_url }
      format.json { head :no_content }
    end
  end
=end

  # GET /payments/users_payments
  # GET /payments/users_payments.json
  def users_payments
    @payments = Payment.where("user_id = ?", current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payments }
    end
  end

  # GET /payments/owner_paymenta
  # GET /payments/owner_paymenta.json
  def owners_payments
    if current_user.role == 'owner' && currenet_user.bankk_account
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

  # GET
  def amount
    @payment = Payment.find(params[:id])
    @amount = PaymentCalculation(@payment)
    respond_to do |format|
      format.html # amount.html.erb
      #format.json { render json: @payment.amount }
      format.json { render json: @amount }
    end
  end
end
