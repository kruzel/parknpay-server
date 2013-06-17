class User < ActiveRecord::Base
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

  has_many :cars, :dependent => :destroy
  has_many :payments, :dependent => :destroy
end
