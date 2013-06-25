class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :terms_of_service
  before_save :ensure_authentication_token

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:active,:role,
    :firstname, :lastname, :gender, :dob,:address_st,:address_state,:address_postcode,:address_country
  # attr_accessible :title, :body
  
  validates :firstname, :lastname, :presence => true, :length => { :minimum => 2 }
  validates :email, :presence => true
  validates :email, :uniqueness => true
  validates :terms_of_service, :acceptance => true
  validates :password, :length => { :in => 6..20 }
  
  has_many :cars, :dependent => :destroy
  has_many :payments, :dependent => :destroy

  attr_accessible :avatar
  has_attached_file :avatar, :styles => {:large => "300x300>", :medium => "100x100>", :thumb => "50x50>" }, :default_url => "/img/User-icon.png"

end
