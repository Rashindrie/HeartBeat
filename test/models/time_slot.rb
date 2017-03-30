require 'test_helper'

class TimeSlotTest < ActiveSupport::TestCase
 fixtures :time_slots

   def test_patient

      time_slot_one = TimeSlot.new :doctor_id => time_slots(:one).doctor_id, 
         :staff_id => time_slots(:one).staff_id, 
         :app_date => time_slots(:one).app_date, 
         :from_time => time_slots(:one).from_time, 
	 :to_time => time_slots(:one).to_time

	#assertion to test that saving a timeslot is successful
      assert time_slot_one.save 

      time_slot_one_copy = TimeSlot.find(time_slot_one.id)

	#assrts that the time_slot_copy found is the needed read record-read a DB
      assert_equal time_slot_one.doctor_id, time_slot_one_copy.doctor_id

      time_slot_one.app_date = "2017-05-09"
	
	#asserts a successfull save after changing value
      assert time_slot_one.save

	#asserts successfull deletion
      assert time_slot_one.destroy


   end

	test "should not save patient without full_name" do
	  patient_wrong = Patient.new
	  assert_not patient_wrong.save
	end
end
