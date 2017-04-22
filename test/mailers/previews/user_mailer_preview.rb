
class UserMailerPreview < ActionMailer::Preview

  def notify_cancel
    UserMailer.notify_cancel(User.first)
  end

  def account_activation
    user = User.find(12)
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
  end

  def password_reset
    user = User.first
    user.reset_token = User.new_token
    UserMailer.password_reset(user)
  end
end