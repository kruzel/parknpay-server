class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  def show
    respond_to do |format|
      format.json { render json: current_user.as_json( :only => [ :id, :email, :password, :firstname, :lastname, :gender, :dob, :inspector , :created_at, :updated_at ], :methods =>  :image_url), :status => 200 }
    end
  end

end
