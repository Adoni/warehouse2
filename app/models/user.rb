class User < ActiveRecord::Base
  attr_accessible :name, :password, :password_confirmation, :type_desc, :admin
  has_secure_password

  validates :name, presence: true, length: {maximum:18}
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates_confirmation_of :password
  validates :type_desc, presence: true
  validates :admin, presence: true

  before_save :create_remember_token

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsave_base64
  end
end
