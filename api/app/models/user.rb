class User < ApplicationRecord
  has_many :microposts
  has_secure_password
  
  before_save { self.email = email.downcase }
  before_create :generate_authentication_token

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255}, 
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, 
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :auth_token, uniqueness: true

  def generate_authentication_token
    begin
      self.auth_token = "#{SecureRandom.urlsafe_base64(64)}"
    end while User.exists?(auth_token: auth_token)
  end

end
