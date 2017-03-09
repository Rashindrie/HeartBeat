class User < ApplicationRecord
  has_secure_password

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