require 'test_helper'
require 'timeslot/add_availability_controller'

# Re-raise errors caught by the controller.
class TimeSlot::AddAvailabilityController
   def rescue_action(e) 
      raise e 
   end
end
#
#class TimeSlot::AddAvailabilityControllerTest < Test::Unit::TestCase
 #  fixtures :appointments
  # def setup
   #   @controller = TimeSlot::AddAvailabilityController.new
    #  @request    = ActionController::TestRequest.new
     # @response   = ActionController::TestResponse.new
   #end

   
#end
