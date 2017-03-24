require 'test_helper'

class TimeSlotControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get time_slot_show_url
    assert_response :success
  end

  test "should get edit" do
    get time_slot_edit_url
    assert_response :success
  end

  test "should get update" do
    get time_slot_update_url
    assert_response :success
  end

end
