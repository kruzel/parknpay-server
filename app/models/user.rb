class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:active,
                  :firstname, :lastname, :gender, :dob,:address_st,:address_state,:address_postcode,:address_country,
                  :bank_account_id, :bank_account, :terms_of_service , :avatar, :profile
  # attr_accessible :title, :body

  before_save :ensure_authentication_token
  
  validates :firstname, :lastname, :presence => true, :length => { :minimum => 2 }
  validates :email, :presence => true
  validates :email, :uniqueness => true
  validates :terms_of_service, :acceptance => {:accept => true}
  #validates :password, :length => { :in => 6..20 }

  has_many :cars, :dependent => :destroy
  has_many :payments, :dependent => :destroy
  belongs_to :bank_account
  has_many :invitations, :class_name => self.to_s, :as => :invited_by

  has_attached_file :avatar, :styles => {:large => "300x300>", :medium => "100x100>", :thumb => "50x50>" }, :default_url => "/img/User-icon.png"

  def image_url
    ::Rails.application.config.server_url + avatar.url(:original)
  end

  protected
  def confirmation_required?
    false
  end

end
