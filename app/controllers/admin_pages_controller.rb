class AdminPagesController < ApplicationController

  before_filter :authenticate_user!

  layout 'admin'

  def dashboard

  end

  def tables

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