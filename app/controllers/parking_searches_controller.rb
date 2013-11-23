class ParkingSearchesController < ApplicationController

  before_filter :authenticate_user!

  load_and_authorize_resource :class => ParkingSearchesController
  layout 'admin'

  def get_free_spots
    #location = params[:location]
    #radius = params[:radius]
    @spots = [{lat: 32.7905,lon: 34.985565},{lat: 32.790554, lon: 34.986466},{lat: 32.789959, lon: 34.986595}]
    #@spots = Payment.where(1location)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @spots }
    end
  end
end
