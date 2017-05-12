require 'selenium-webdriver'

class LoginClass < ActiveSupport::TestCase

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @driver.navigate.to "localhost:3000/login"
    @driver.manage.window.maximize
  end


  def teardown
    @driver.quit
  end


  def test_login
    @driver.find_element(:id, "email").send_keys "rashindrieperera@gmail.com"
    @driver.find_element(:id, "password").send_keys "password1234"
    @driver.find_element(:id, "submit").click
    sleep 0.4
    assert(@driver.find_element(:tag_name => "body").text.include?("Logged in"),"Page contains the text")
    sleep 0.4
    @driver.find_element(:id, "logout" ).click
    sleep 0.4
    assert(@driver.find_element(:tag_name => "body").text.include?("Sign In"),"Page contains the text")

  end
end