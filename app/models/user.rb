class User < ApplicationRecord
  has_secure_password

  belongs_to :patient, { :optional => true}
  belongs_to :doctor, { :optional => true}
  belongs_to :staff, { :optional => true}

  def admin?
    self.user_type == 0
  end

  def patient?
    self.user_type == 1
  end

  def doctor?
    self.user_type == 2
  end

  def staff?
    self.user_type == 3
  end

end
