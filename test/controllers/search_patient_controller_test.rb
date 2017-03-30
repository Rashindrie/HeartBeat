require 'test_helper'
require 'appointment/search_appointments_controller'

# Re-raise errors caught by the controller.
class SearchPatientsController
   def rescue_action(e) 
      raise e 
   end
end
#
#class Appointment::SearchAppointmentsControllerTest < Test::Unit::TestCase
 #  fixtures :appointments
  # def setup
   #   @controller = Appointment::SearchAppointmentsController.new
    #  @request    = ActionController::TestRequest.new
     # @response   = ActionController::TestResponse.new
   #end

   #def test_search_appointments
    #  get :search, :time_slot_id => 1
      #assert_not_nil assigns(:appointment)
     # assert_equal appointments(:one).time_slot_id, assigns(:appointment).time_slot_id
     # assert_valid assigns(:appointment)
      #assert_redirected_to :action => 'search'
  # end

   #def test_search_not_found
    #  get :search, :time_slot_id => 1
     # assert_redirected_to :action => 'show'
      #assert_equal 'No such appointment available', flash[:error]
   #end
#end
