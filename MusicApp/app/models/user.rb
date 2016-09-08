class User < ActiveRecord::Base

  attr_reader :password

  validates :email, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: { message: "Must have a password" }
  validates :password, length: { minimum: 6 }, allow_nil: true

  after_initialize :ensure_session_token


  def self.find_by_credentials(email, pass)
    user = User.find_by_email(email)
    user if user && is_password(pass)
  end

  def generate_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = generate_session_token
    save
    session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(pass)
    BCrypt::Password.new(password_digest).is_password?(pass)
  end


  private
  def ensure_session_token
    self.session_token ||= generate_session_token
  end

end
