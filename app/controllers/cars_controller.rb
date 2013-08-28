class CarsController < ApplicationController

  before_filter :authenticate_user!

  layout 'admin'

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.where("user_id = ?", current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cars.as_json( :only => [ :id, :user_id, :archive , :car_description, :license_plate, :created_at, :updated_at ], :methods =>  :image_url) }
    end
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
    @car = Car.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @car.as_json( :only => [ :id, :user_id, :archive , :car_description, :license_plate, :created_at, :updated_at ], :methods =>  :image_url) }
    end
  end

  # GET /cars/new
  # GET /cars/new.json
  def new
    @car = Car.new
    @car.user = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @car }
    end
  end

  # GET /cars/1/edit
  def edit
    @car = Car.find(params[:id])
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(params[:car])
    @car.user = current_user

    respond_to do |format|
      if @car.save
        format.html { redirect_to [@car.user,@car], notice: 'Car was successfully created.' }
        format.json { render json: @car.as_json( :only => [ :id, :user_id, :archive , :car_description, :license_plate, :created_at, :updated_at ], :methods =>  :image_url), status: :created, location: [@car.user,@car] }
      else
        format.html { render action: "new" }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  #POST user/:user_id/cars/:id/upload_image.json
  def upload_image
    @car = Car.find(params[:id])

    respond_to do |format|
      if @car.update_attributes(:car_image => params[:file])
         format.json { head :no_content }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # PUT /cars/1
  # PUT /cars/1.json
  def update
    @car = Car.find(params[:id])

    respond_to do |format|
      if @car.update_attributes(params[:car])
        format.html { redirect_to [@car.user,@car], notice: 'Car was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
=begin
  def destroy
    @car = Car.find(params[:id])
    @car.destroy

    respond_to do |format|
      format.html { redirect_to user_cars_url }
      format.json { head :no_content }
    end
  end
=end
end
