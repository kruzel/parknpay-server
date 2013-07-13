class RatesController < ApplicationController
  # GET /rates
  # GET /rates.json
  def index
    @rates = Rate.where("area_id = ?",params[:area_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rates }
    end
  end

  # GET /rates/1
  # GET /rates/1.json
  def show
    @rate = Rate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rate }
    end
  end

  # GET /rates/new
  # GET /rates/new.json
  def new
    unless current_user.try(:admin?) || current_user.try(:manager?)
      respond_to do |format|
        format.html render :file => 'public/401.html'
        format.json { render :status => 401 }
      end
      return
    end

    @rate = Rate.new
    @rate.area = Area.find(params[:area_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rate }
    end
  end

  # GET /rates/1/edit
  def edit
    unless current_user.try(:admin?) || current_user.try(:manager?)
      respond_to do |format|
        format.html render :file => 'public/401.html'
        format.json { render :status => 401 }
      end
      return
    end

    @rate = Rate.find(params[:id])
    @rate.area = Area.find(params[:area_id])
  end

  # POST /rates
  # POST /rates.json
  def create
    unless current_user.try(:admin?) || current_user.try(:manager?)
      respond_to do |format|
        format.html render :file => 'public/401.html'
        format.json { render :status => 401 }
      end
      return
    end

    @rate = Rate.new(params[:rate])
    @rate.area = Area.find(params[:area_id])

    respond_to do |format|
      if @rate.save
        format.html { redirect_to [@rate.area.city,@rate.area,@rate], notice: 'Rate was successfully created.' }
        format.json { render json: @rate, status: :created, location: [@rate.area.city,@rate.area,@rate] }
      else
        format.html { render action: "new" }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rates/1
  # PUT /rates/1.json
  def update
    unless current_user.try(:admin?) || current_user.try(:manager?)
      respond_to do |format|
        format.html render :file => 'public/401.html'
        format.json { render :status => 401 }
      end
      return
    end

    @rate = Rate.find(params[:id])
    @rate.area = Area.find(params[:area_id])

    respond_to do |format|
      if @rate.update_attributes(params[:rate])
        format.html { redirect_to [@rate.area.city,@rate.area,@rate], notice: 'Rate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rates/1
  # DELETE /rates/1.json
=begin
  def destroy
    @rate = Rate.find(params[:id])
    @rate.destroy

    respond_to do |format|
      format.html { redirect_to rates_url }
      format.json { head :no_content }
    end
  end
=end
end
