class User < ApplicationRecord
  has_secure_password

  belongs_to :patient, { :optional => true}
  belongs_to :doctor, { :optional => true}
  belongs_to :staff, { :optional => true}

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
