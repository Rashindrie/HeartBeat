
class UserMailerPreview < ActionMailer::Preview

  def notify_cancel
    UserMailer.notify_cancel(User.first)
  end
end