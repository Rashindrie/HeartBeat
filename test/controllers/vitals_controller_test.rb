require 'test_helper'

class VitalsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get vitals_edit_url
    assert_response :success
  end

  test "should get update" do
    get vitals_update_url
    assert_response :success
  end

  test "should get show" do
    get vitals_show_url
    assert_response :success
  end

end
