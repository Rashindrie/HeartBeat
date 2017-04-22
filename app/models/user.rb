class User < ApplicationRecord
  has_secure_password

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

end
