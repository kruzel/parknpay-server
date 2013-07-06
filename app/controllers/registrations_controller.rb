class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json

  def create
    respond_to do |format|
      format.html { super }
      format.json {
        build_resource
=begin
    resource.skip_confirmation!
=end
        if resource.save!
          sign_in resource
          render :status => 200,
                 :json => { :success => true,
                            :info => "Registered",
                            :data => { :user => resource,
                                       :auth_token => current_user.authentication_token } }
        else
          render :status => :unprocessable_entity,
                 :json => { :success => false,
                            :info => resource.errors,
                            :data => {} }
        end
     }
    end
  end
end
