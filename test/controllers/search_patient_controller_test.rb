require 'test_helper'

# Re-raise errors caught by the controller.
class PatientController
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
   get patient_url
   assert_response :success
end

def test_index_template_rendered
   get :index
   assert_template :index
   assert_equal Patient.all, assigns(:patients)
end