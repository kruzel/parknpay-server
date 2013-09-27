class Users::InvitationsController < Devise::InvitationsController
  before_filter :authenticate_user!

  def has_invitations_left?
    return true
  end

  def new
    @pass = SecureRandom.base64
    super
  end

  def create
    if current_user.bank_account.nil?
      @user = User.find_by_email(params[:user][:email])
      if @user.nil?
        @user = User.new(params[:user])
        @user.bank_account = current_user.bank_account
        @user.role = 'owner'
        @user.skip_confirmation!
        success = @user.save!
      else
        success = true
      end
    else
      success = false
    end

    if success
      @user.invite!(current_user)

      if @user.errors.empty? && success
        set_flash_message :notice, :send_instructions, :email => @user.email
        respond_with current_user, :location => after_invite_path_for(current_user)
      else
        respond_with_navigational(current_user) { render :new }
      end
    end
  end

end
