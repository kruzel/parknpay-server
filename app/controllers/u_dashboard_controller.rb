class UDashboardController < ApplicationController
  
    before_filter :authenticate_user!

  
  # GET /home
  # GET /home.json
  def index
    @user = current_user
    @cars = Car.where("user_id = ?", current_user.id)
  end
  
  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      flash[:info] = "Successfully updated profile."
      redirect_to :action => :index
    else
      redirect_to :action => :index
    end
  end
end
