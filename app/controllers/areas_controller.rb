class AreasController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  layout 'owner'

  # GET /areas
  # GET /areas.json
  def index
    @areas = Area.where("city_id = ?", params[:city_id])
    @city = City.find(params[:city_id])

    respond_to do |format|
      if current_user.bank_account_id
        format.html # index.html.erb
        format.json { render json: @city.as_json(:only => [:id, :name], :include => [:areas => { :only => [:id, :name, :polygon ] }] ) }
      else
        format.html { render new_bank_account_path, notice: 'can not define areas without having a defined bank account' }
        format.json { render json: 'missing bank account', status: :unprocessable_entity }
      end
    end
  end

  # PUT /areas/update_areas.json
  def update_areas
    @city = City.find(params[:city_id])
    areas = JSON.parse(request.body.read)

    success = true
    areas.each do |area|
      @area = nil
      begin
        @area = Area.find(area['id'])
      rescue => e
        #nothing to do
      end
      area_success = false
      unless @area
        @area = Area.new()
      end

      @area.name = area['name']
      @area.city_id = params[:city_id]
      @area.bank_account = current_user.bank_account
      @area.polygon = area['polygon'].to_json
      area_success = @area.save

      unless area_success
        success = false
      end
    end

    respond_to do |format|
      if success
        format.json { head :no_content }
      else
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
    @area = Area.find(params[:id])
    @city = @area.city

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @area }
    end
  end

  # GET /areas/new
  # GET /areas/new.json
  def new
    @area = Area.new
    @area.city = City.find(params[:city_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @area }
    end
  end

  # GET /areas/1/edit
  def edit
    @area = Area.find(params[:id])
    @area.city = City.find(params[:city_id])
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(params[:area])
    @area.city = City.find(params[:city_id])
    @area.bank_account = current_user.bank_account

    respond_to do |format|
      if @area.save
        format.html { redirect_to [@area.city,@area], notice: 'Area was successfully created.' }
        format.json { render json: @area, status: :created, location: [@area.city,@area] }
      else
        format.html { render action: "new" }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /areas/1
  # PUT /areas/1.json
  def update
    @area = Area.find(params[:id])
    @area.city = City.find(params[:city_id])

    respond_to do |format|
      if @area.update_attributes(params[:area])
        format.html { redirect_to [@area.city,@area], notice: 'Area was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
=begin
  def destroy
    @area = Area.find(params[:id])
    @area.destroy

    respond_to do |format|
      format.html { redirect_to areas_url }
      format.json { head :no_content }
    end
  end
=end

  def find_by_street
    city = City.where('name like ?',params[:city_name]).first
    #logger.error("city_id= "+city_id.to_json)
    if city
      @area = Area.joins(:streets).where('areas.city_id like ? AND streets.name like ?',city.id  , params[:street_name])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @area }
    end
  end

end
