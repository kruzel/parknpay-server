class UDashboardController < ApplicationController
  # GET /home
  # GET /home.json
  def index
    @user = current_user
  end
  
  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      flash[:notice] = "Successfully updated post."
      redirect_to :action => :index
    else
      redirect_to :action => :index
    end
  end
end
