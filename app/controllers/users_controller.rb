class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  def show
    respond_to do |format|
      format.json { render json: { :user => current_user.as_json( :only => [ :id, :email, :password, :firstname, :lastname, :gender, :dob, :inspector , :created_at, :updated_at ], :methods =>  :image_url)}, :status => 200 }
    end
  end

  def assign_owners
    @creditor = Creditor.find(current_user.creditor_id)  if !current_user.creditor_id.nil?

    if @creditor.nil?
      render 'not_found', :layout => 'owner'
    else
      render :controller => 'users', :action => 'sign_up', :id => current_user.id
    end
  end

end
