class OwnerPagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  layout 'admin'

  def dashboard

  end

  def tables
    #@billing_hist_data = Payment.order('start_time DESC').all
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
