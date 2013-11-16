class AreasController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  layout 'owner'

  # GET /areas
  # GET /areas.json
=begin
  [{
      "name" : "Sidney",
    "metadata" : { "lat":24.88 , "lon":-70.26 }
      "attr" : { "id" : "0"},
      "children" :
      [
          {
              "name" :"Beach Area",
              "polygons" :
              [
                  {"lat":25.774252, "lon":-80.190262},
                  {"lat":18.464652, "lon":-66.118292},
                  {"lat":32.321384, "lon":-64.75737}
              ]  ,
              "attr" : { "id" : "0"}
          },
          {
              "name" :"Opera",
              "polygons" :
              [
                  {"lat":26.774252, "lon":-82.190262},
                  {"lat":17.4664652, "lon":-61.118292},
                  {"lat":30.321384, "lon":-62.75737}
              ]  ,
              "attr" : { "id" : "1"  }
          }
      ]
  }];
=end

  def index
    @areas = Area.where("city_id = ?", params[:city_id])
    @city = City.find(params[:city_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @city.as_json(:only => [:id, :name], :include => [:areas => { :only => [:id, :name, :polygon ] }] ) }
    end
  end

  # PUT /areas/update_areas.json
  def update_areas
    @city = City.find(params[:id])
    areas = params[:areas]

    success = true
    areas.each do [area]
      @area = Area.find(area.id)
      area_success = false
      if @area
        area_success = @area.update_attributes(area)
      else
        @area = Area.new(area)
        @area.city_id = params[:id]
        @area.bank_account = current_user.bank_account
        area_success = @area.save
      end
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
    #logger.error("city= "+city.to_json)
    if city
      @area = Area.joins(:streets).where('areas.city_id like ? AND streets.name like ?',city.id  , params[:street_name])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @area }
    end
  end
end
