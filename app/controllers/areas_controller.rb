class AreasController < ApplicationController
  # GET /areas
  # GET /areas.json
  def index
    @areas = Area.where("city_id = ?", params[:city_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @areas }
    end
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
    @area = Area.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @area }
    end
  end

  # GET /areas/new
  # GET /areas/new.json
  def new
    unless current_user.try(:admin?) || current_user.try(:manager?)
      respond_to do |format|
        format.html render :file => 'public/401.html'
        format.json { render :status => 401 }
      end
      return
    end

    @area = Area.new
    @area.city = City.find(params[:city_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @area }
    end
  end

  # GET /areas/1/edit
  def edit
    unless current_user.try(:admin?) || current_user.try(:manager?)
      respond_to do |format|
        format.html render :file => 'public/401.html'
        format.json { render :status => 401 }
      end
      return
    end

    @area = Area.find(params[:id])
    @area.city = City.find(params[:city_id])
  end

  # POST /areas
  # POST /areas.json
  def create
    unless current_user.try(:admin?) || current_user.try(:manager?)
      respond_to do |format|
        format.html render :file => 'public/401.html'
        format.json { render :status => 401 }
      end
      return
    end

    @area = Area.new(params[:area])
    @area.city = City.find(params[:city_id])

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
    unless current_user.try(:admin?) || current_user.try(:manager?)
      respond_to do |format|
        format.html render :file => 'public/401.html'
        format.json { render :status => 401 }
      end
      return
    end

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
end
