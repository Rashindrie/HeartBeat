require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

 # test "account_activation" do
    #user =users(:one)
    #user.activation_token = User.new_token
    #mail = UserMailer.account_activation(user)
    #assert_equal "HeartBeat: Account Activation", mail.subject
    #assert_equal [user.email], mail.to
    #assert_equal ["hbeat.team@gmail.com"], mail.from
   # assert_match user.name,               mail.body.encoded
   # assert_match user.activation_token,   mail.body.encoded
    #assert_match CGI.escape(user.email),  mail.body.encoded
 # end

  #test "password_reset" do
   # user = users(:one)
    #user.reset_token = User.new_token
   # mail = UserMailer.password_reset(user)
    #assert_equal "HeartBeat: Reset your password", mail.subject
   # assert_equal [user.email], mail.to
    #assert_equal ["hbeat.team@gmail.com"], mail.from
   # assert_match user.reset_token,        mail.body.encoded
   # assert_match CGI.escape(user.email),  mail.body.encoded
 # end
end
