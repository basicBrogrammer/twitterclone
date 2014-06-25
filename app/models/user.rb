class User < ActiveRecord::Base
  #before the User email is saved the email is transformed to all lowercase letters
  before_save {self.email = email.downcase}
  validates :name, presence: true
  #creates a variable to which the regular expression is stored
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #the uniqueness validation is true with the option making it not case sensitive
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  #has secure password, via documentation, is suppose to create the :password and password_confirmation attributes
  #automatically. I have had problems with this being the case.
  has_secure_password
  validates :password, length: { minimum: 6 }

end
