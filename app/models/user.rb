class User < ApplicationRecord
  attr_accessor :activation_token

  has_secure_password


  before_create :create_activation_digest
  before_save { self.email = email.downcase }

  belongs_to :patient, { :optional => true}
  belongs_to :doctor, { :optional => true}
  belongs_to :staff, { :optional => true}

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i


  validates :email,
            presence: true,
            length: { maximum: 100 },
            format: { with: EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates_confirmation_of :email,
                            :unless => Proc.new { |a| a.email.blank? }

  validates_presence_of :password_digest
  validates_length_of :password_digest, :within => 6..100
  validates_confirmation_of :password_digest,
                            :unless => Proc.new { |a| a.password_digest.blank? }

  validates :status, :inclusion => { :in => [true, false] }

  validates_associated :patient, :doctor, :staff


  def admin?
    self.role == 0
  end

  def patient?
    self.role == 1
  end

  def doctor?
    self.role == 2
  end

  def staff?
    self.role== 3
  end


  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sends password email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end


  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Activates an account.
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end


  private

  def create_activation_digest
    # Create the token and digest.
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end


end
