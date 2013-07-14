class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  def show
    respond_to do |format|
      format.json { render :json => { :user => current_user }, :status => 200 }
    end
  end

end
