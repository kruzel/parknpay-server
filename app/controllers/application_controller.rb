class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  before_filter :load_vars
  before_filter :cors_preflight_check if Rails.env.development?
  #after_filter :cors_set_access_control_headers

# For all responses in this controller, return the CORS access control headers in dev mode.

  def cors_preflight_check
    logger.debug 'cors_preflight_check'

    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS,PUT, DELETE'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
    headers['Access-Control-Max-Age'] = '1728000'

  end

  def after_sign_in_path_for(resource)
    dashboard_admin_pages_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/403", :formats => [:html], :status => :forbidden, :layout => false

=begin
    respond_to do |format|
      format.html render :file => "#{Rails.root}/public/403", :formats => [:html], :status => :forbidden, :layout => false
      format.json { render :status => :forbidden }
    end
=end

    ## to avoid deprecation warnings with Rails 3.2.x (and incidentally using Ruby 1.9.3 hash syntax)
    ## this render call should be:
    # render file: "#{Rails.root}/public/403", formats: [:html], status: 403, layout: false
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
