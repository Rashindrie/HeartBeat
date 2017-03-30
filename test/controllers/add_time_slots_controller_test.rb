require 'test_helper'

# Re-raise errors caught by the controller.
class AddTimeSlotsController
   def rescue_action(e)
      raise e
   end
end
#
def test_index_response
   get :index
   assert_response :success
end

def test_index
   get time_slots_url
   assert_response :success
end

def test_index_template_rendered
   get :index
   assert_template :index
   assert_equal TimeSlot.all, assigns(:time_slots)
end