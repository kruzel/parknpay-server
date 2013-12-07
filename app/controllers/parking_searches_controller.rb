class ParkingSearchesController < ApplicationController

  before_filter :authenticate_user!

  load_and_authorize_resource :class => ParkingSearchesController
  layout 'admin'

  def get_free_spots
    lat = params[:location][:lat] #y_pos
    lon = params[:location][:lon] #x_pos
    distance = params[:distance] #bounderies distance
    time = Time.now - params[:time_delta]
    @spots = Payment.where('((? > y_pos - ? or ? < y_pos + ?) and (? > x_pos - ? or ? < x_pos + ?)) and (end_time != null and end_time > ?)',lat,distance,lat,distance,lon,distance,lon,distance,time);

    #@spots = [{lat: 32.7905,lon: 34.985565},{lat: 32.790554, lon: 34.986466},{lat: 32.789959, lon: 34.986595}]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @spots }
    end
  end
end
