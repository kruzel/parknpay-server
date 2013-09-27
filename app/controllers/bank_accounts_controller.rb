class BankAccountsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  layout 'owner'

  # GET /bank_accounts
  # GET /bank_accounts.json
  def index
    @bank_accounts = BankAccount.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bank_accounts }
    end
  end

  # GET /bank_accounts/1
  # GET /bank_accounts/1.json
  def show
    @bank_account = BankAccount.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bank_account }
    end
  end

  # GET /bank_accounts/new
  # GET /bank_accounts/new.json
  def new
    unless current_user.bank_account_id.nil?
      @bank_account = BankAccount.find(current_user.bank_account_id)
      redirect_to @bank_account
      return
    end

    @bank_account = BankAccount.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bank_account }
    end
  end

  # GET /bank_accounts/1/edit
  def edit
    @bank_account = BankAccount.find(params[:id])
  end

  # POST /bank_accounts
  # POST /bank_accounts.json
  def create
   @bank_account = BankAccount.new(params[:bank_account])

    respond_to do |format|
      if @bank_account.save
        current_user.bank_account_id = @bank_account.id
        current_user.save

        format.html { redirect_to edit_bank_account_path(@bank_account), notice: 'BankAccount was successfully created.' }
        format.json { render json: @bank_account, status: :created, location: @bank_account }
      else
        format.html { render action: "new" }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bank_accounts/1
  # PUT /bank_accounts/1.json
  def update
    @bank_account = BankAccount.find(params[:id])

    respond_to do |format|
      if @bank_account.update_attributes(params[:bank_account])
        format.html { redirect_to edit_bank_account_path, notice: 'BankAccount was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_accounts/1
  # DELETE /bank_accounts/1.json
=begin
  def destroy
    @bank_account = BankAccount.find(params[:id])
    @bank_account.destroy

    respond_to do |format|
      format.html { redirect_to bank_accounts_url }
      format.json { head :no_content }
    end
  end
=end

  def new_assign_owners
    @bank_account = BankAccount.find(current_user.bank_account_id)  if !current_user.bank_account_id.nil?

    if @bank_account.nil?
      render 'not_found', :layout => 'owner'
    else
      redirect_to :controller => 'users', :action => 'admin_new_user', :admin_id => current_user.id, :bank_account_id => @bank_account.id
    end
  end

  def create_assign_owners

  end
end
