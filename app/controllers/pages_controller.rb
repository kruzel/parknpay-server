# encoding: utf-8

class PagesController < ApplicationController
  def home
    render layout: 'alternative'
  end

  def about_us

  end

  def contact_us

  end

  def team

  end

  def features

  end

  def components

  end

  def sitemap

  end

  def error_404
    render 'error_404', layout: 'alternative'
  end

end