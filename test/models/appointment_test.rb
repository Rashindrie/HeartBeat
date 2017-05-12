require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
 fixtures :appointments

   def test_appointment

      appointment_one = Appointment.new :time_slot_id => appointments(:one).time_slot_id, 
         :patient_id => appointments(:one).patient_id, :status => appointments(:one).status 

	#assertion to test that saving a appointment is successful
      assert appointment_one.save 

      appointment_one_copy = Appointment.find(appointment_one.id)

	#assrts that the appointment_copy found is the needed read record-read a DB
      assert_equal appointment_one.patient_id, appointment_one_copy.patient_id

      appointment_one.time_slot_id = 2
	
	#asserts a successfull save after changing value
      assert appointment_one.save

	#asserts successfull deletion
      assert appointment_one.destroy


   end

	test "should not save patient without full_name" do
	  patient_wrong = Patient.new
	  assert_not patient_wrong.save
	end
end
