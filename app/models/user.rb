class User < ApplicationRecord
  has_secure_password

  belongs_to :patient, { :optional => true}
  belongs_to :doctor, { :optional => true}
  belongs_to :staff, { :optional => true}

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  validates_presence_of :email
  validates_format_of :email, :with => EMAIL_REGEX
  validates_uniqueness_of :email
  validates_length_of :email,  :maximum => 100
  validates_confirmation_of :email
  validates_presence_of :password
  validates_length_of :password, :within => 6..100
  validates_confirmation_of :password



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
