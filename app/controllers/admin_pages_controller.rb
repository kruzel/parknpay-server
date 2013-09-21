class AdminPagesController < ApplicationController

  before_filter do
    :authenticate_user!
    #redirect_to dashboard_owner_pages_url if current_user.role != "user"
  end

  layout 'admin'

  def dashboard

  end

  def tables
	@billing_hist_data = Payment.order('start_time DESC').all
  end

  def elements

  end

  def media

  end

  def forms

  end

  def grid

  end

  def buttons

  end

  def notification

  end

  def calendar

  end

  def chat

  end

  def charts

  end

  def profile

  end
end