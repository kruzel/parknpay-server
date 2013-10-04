class City < ActiveRecord::Base
  attr_accessible :name
  has_many :areas

  validates :area, :presence=>true

end
