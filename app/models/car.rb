class Car < ActiveRecord::Base
  belongs_to :user
  attr_accessible :car_description, :license_plate, :car_image, :user

  has_attached_file :car_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  def image_url
    ::Rails.application.config.server_url + car_image.url(:thumb)
  end

end
