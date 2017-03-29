require 'test_helper'

class StaffTest < ActiveSupport::TestCase
  fixtures :staffs

   def test_staff

      staff_one = Staff.new :full_name => staffs(:one).full_name, 
         :first_name => staffs(:one).first_name, 
         :middle_name => staffs(:one).middle_name, 
         :last_name => staffs(:one).last_name, 
	 :gender => staffs(:one).gender, 
	 :email => staffs(:one).email, 
	 :telephone => staffs(:one).telephone

	#assertion to test that saving a patient is successful
      assert staff_one.save 

      staff_one_copy = Staff.find(staff_one.id)

	#assrts that the patient_copy found is the needed read record-read a DB
      assert_equal staff_one.full_name, staff_one_copy.full_name

      staff_one.full_name = "June Mary Ann"
	
	#asserts a successfull save after changing value
      assert staff_one.save

	#asserts successfull deletion
      assert staff_one.destroy
   end
end
