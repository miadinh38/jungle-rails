class User < ApplicationRecord

  has_secure_password

  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by("lower(email) = ?", email.strip.downcase)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end  
  end  

end
