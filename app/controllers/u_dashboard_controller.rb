class UDashboardController < ApplicationController
  # GET /home
  # GET /home.json
  def index
    @user = current_user
  end
  
  def update_personal_details
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render "edit"
    end
  end
end
