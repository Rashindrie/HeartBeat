require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
  describe "GET /users_signups" do
    it "works! (now write some real specs)" do
      get '/signup/registerPatient'
      expect(response).to have_http_status(200)
    end
  end



  test "invalid signup information" do
    get '/signup/registerPatient'
    assert_no_difference 'User.count' do
      post '/signup', params: { session: {   full_name:  "",
                                             first_name:  "",
                                             last_name:  "",
                                             telephone:  "",
                                             date_of_birth:  "",
                                             email: "user@invalid",
                                             password:              "foo",
                                             password_confirmation: "bar" } }
    end

    assert_template '/signup/registerPatient'
    assert_select 'div#<CSS id for error explanation>'
    assert_select 'div.<CSS class for field with error>'
  end

  test "valid signup information" do
    get '/signup/registerPatient'
    assert_difference 'User.count', 1 do
      post '/signup', params: { session: {   full_name:  "Bruno Perera",
                                             first_name:  "Bruno",
                                             last_name:  "Perera",
                                             telephone:  "0112888888",
                                             date_of_birth:  "12/10/1994",
                                             email: "burno@gmail.com",
                                             password:              "password1234",
                                             password_confirmation: "password1234" } }
    end
    follow_redirect!
    assert_template '/patient/home/'
    assert_not flash.FILL_IN
  end
end
