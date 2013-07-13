class CreditorsController < ApplicationController
  # GET /creditors
  # GET /creditors.json
  def index
    @creditors = Creditor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @creditors }
    end
  end

  # GET /creditors/1
  # GET /creditors/1.json
  def show
    @creditor = Creditor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @creditor }
    end
  end

  # GET /creditors/new
  # GET /creditors/new.json
  def new
    unless current_user.try(:admin?) || current_user.try(:customer?)
      respond_to do |format|
        format.html { render :file => 'public/401.html' }
        format.json { render :status => 401 }
      end
      return
    end

    @creditor = Creditor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @creditor }
    end
  end

  # GET /creditors/1/edit
  def edit
    unless current_user.try(:admin?) || current_user.try(:customer?)
      respond_to do |format|
        format.html { render :file => 'public/401.html' }
        format.json { render :status => 401 }
      end
      return
    end

    @creditor = Creditor.find(params[:id])
  end

  # POST /creditors
  # POST /creditors.json
  def create
    unless current_user.try(:admin?) || current_user.try(:customer?)
      respond_to do |format|
        format.html { render :file => 'public/401.html' }
        format.json { render :status => 401 }
      end
      return
    end

    @creditor = Creditor.new(params[:creditor])

    respond_to do |format|
      if @creditor.save
        format.html { redirect_to @creditor, notice: 'Creditor was successfully created.' }
        format.json { render json: @creditor, status: :created, location: @creditor }
      else
        format.html { render action: "new" }
        format.json { render json: @creditor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /creditors/1
  # PUT /creditors/1.json
  def update
    unless current_user.try(:admin?) || current_user.try(:customer?)
      respond_to do |format|
        format.html { render :file => 'public/401.html' }
        format.json { render :status => 401 }
      end
      return
    end

    @creditor = Creditor.find(params[:id])

    respond_to do |format|
      if @creditor.update_attributes(params[:creditor])
        format.html { redirect_to @creditor, notice: 'Creditor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @creditor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /creditors/1
  # DELETE /creditors/1.json
=begin
  def destroy
    @creditor = Creditor.find(params[:id])
    @creditor.destroy

    respond_to do |format|
      format.html { redirect_to creditors_url }
      format.json { head :no_content }
    end
  end
=end
end
