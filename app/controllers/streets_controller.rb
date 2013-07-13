class StreetsController < ApplicationController
  # GET /streets
  # GET /streets.json
  def index
    @streets = Street.where("area_id = ?",params[:area_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @streets }
    end
  end

  # GET /streets/1
  # GET /streets/1.json
  def show
    @street = Street.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @street }
    end
  end

  # GET /streets/new
  # GET /streets/new.json
  def new
    unless current_user.try(:admin?) || current_user.try(:customer?)
      respond_to do |format|
        format.html { render :file => 'public/401.html' }
        format.json { render :status => 401 }
      end
      return
    end

    @street = Street.new
    @street.area = Area.find(params[:area_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @street }
    end
  end

  # GET /streets/1/edit
  def edit
    unless current_user.try(:admin?) || current_user.try(:customer?)
      respond_to do |format|
        format.html { render :file => 'public/401.html' }
        format.json { render :status => 401 }
      end
      return
    end

    @street = Street.find(params[:id])
    @street.area = Area.find(params[:area_id])
  end

  # POST /streets
  # POST /streets.json
  def create
    unless current_user.try(:admin?) || current_user.try(:customer?)
      respond_to do |format|
        format.html { render :file => 'public/401.html' }
        format.json { render :status => 401 }
      end
      return
    end

    @street = Street.new(params[:street])
    @street.area = Area.find(params[:area_id])

    respond_to do |format|
      if @street.save
        format.html { redirect_to [@street.area.city,@street.area,@street], notice: 'Street was successfully created.' }
        format.json { render json: @street, status: :created, location: [@street.area.city,@street.area,@street] }
      else
        format.html { render action: "new" }
        format.json { render json: @street.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /streets/1
  # PUT /streets/1.json
  def update
    unless current_user.try(:admin?) || current_user.try(:customer?)
      respond_to do |format|
        format.html { render :file => 'public/401.html' }
        format.json { render :status => 401 }
      end
      return
    end

    @street = Street.find(params[:id])
    @street.area = Area.find(params[:id])

    respond_to do |format|
      if @street.update_attributes(params[:street])
        format.html { redirect_to [@street.area.city,@street.area,@street], notice: 'Street was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @street.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /streets/1
  # DELETE /streets/1.json
=begin
  def destroy
    @street = Street.find(params[:id])
    @street.destroy

    respond_to do |format|
      format.html { redirect_to streets_url }
      format.json { head :no_content }
    end
  end
=end
end
