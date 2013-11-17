class CitiesController < ApplicationController
  
    before_filter :authenticate_user!

    load_and_authorize_resource
    layout 'owner'

  # GET /cities
  # GET /cities.json
  def index
    @cities = City.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cities }
    end
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
 @city = City.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @city }
    end
  end

  # GET /cities/new
  # GET /cities/new.json
  def new
    @city = City.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @city }
    end
  end

  # GET /cities/1/edit
  def edit
    @city = City.find(params[:id])
  end

  # POST /cities
  # POST /cities.json
  def create
    @city = City.new(params[:city_id])

    respond_to do |format|
      if @city.save
        format.html { redirect_to @city, notice: 'City was successfully created.' }
        format.json { render json: @city, status: :created, location: @city }
      else
        format.html { render action: "new" }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cities/1
  # PUT /cities/1.json
  def update
    @city = City.find(params[:id])

    respond_to do |format|
      if @city.update_attributes(params[:city_id])
        format.html { redirect_to @city, notice: 'City was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
=begin
  def destroy
    @city_id = City.find(params[:id])
    @city_id.destroy

    respond_to do |format|
      format.html { redirect_to cities_url }
      format.json { head :no_content }
    end
  end
=end

  # GET /cities/get_rates
  # GET /cities/get_rates.json
  def get_rates
    @cities = City.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cities.as_json(:include => { :areas => { :include => { :rates => {:only => [:id, :start_day_a_week, :end_day_a_week, :rate, :currency, :area_id, :archive], :methods => [ :start_time_int, :end_time_int ]  }}}}) }
    end
  end

  #params: city_name, lat, lon
  def get_area_by_lat_lon
    city = City.find_by_name(params[:city_name])
    areas = @city.areas
    area = nil
    areas.each do |tmp_area|
      #fidn the polygon
      polygon = tmp_area.polygon
      vertx = Array.new
      verty = Array.new
      polygon = JSON.parse(polygon)
      polygon.each do |point|
        vertx = point.x
        verty = point.y
      end
      nvert = polygon.size
      if pnpoly(nvert, vertx, verty, params[:lat], params[:lon])%2!=0
        area = tmp_area;
        break
      end
    end

    respond_to do |format|
      if area
        format.json { render json: {:area_id => area.id} }
      else
        format.json { head :not_found }
      end
    end
  end

  private

  #nvert: Number of vertices in the polygon. Whether to repeat the first vertex at the end.
  #vertx, verty: Arrays containing the x- and y-coordinates of the polygon's vertices.
  #testx, testy: X- and y-coordinate of the test point.

  def pnpoly(nvert, vertx, verty, testx, testy)
      c = 0
      i = 0
      while  j = nvert-1 && i < nvert
          j = i++
          if ( ((verty[i]>testy) != (verty[j]>testy)) &&
              (testx < (vertx[j]-vertx[i]) * (testy-verty[i]) / (verty[j]-verty[i]) + vertx[i]) )
              c = !c
          end
      end
      return c
  end
end
