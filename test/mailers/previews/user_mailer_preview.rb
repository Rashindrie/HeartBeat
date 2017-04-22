
class UserMailerPreview < ActionMailer::Preview

  def notify_cancel
    UserMailer.notify_cancel(User.first)
  end

  def account_activation

    UserMailer.account_activation(User.find(12))
  end

  def password_reset
    UserMailer.password_reset(User.first)
  end
end