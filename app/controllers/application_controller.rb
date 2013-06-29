class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  before_filter :load_vars
  
  def after_sign_in_path_for(resource)
    udashboard_path
  end
  
  protected

  def load_vars
    unless request.xhr? #check if ajax call
      if(user_signed_in?)
        @user = User.find(current_user.id)
      else
        @user = User.new
      end
    end
  end
end
