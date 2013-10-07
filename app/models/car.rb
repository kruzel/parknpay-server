class Car < ActiveRecord::Base
  belongs_to :user
  has_many :cars
  attr_accessible :car_description, :license_plate, :car_image, :user, :archive

  has_attached_file :car_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/img/:style/missing.png"

  validates :license_plate, :presence => true
  validates :license_plate, :uniqueness => true
  validates :user, :presence=>true

  def image_url
    ::Rails.application.config.server_url + car_image.url(:thumb)
  end

end
