require 'test_helper'

class DoctorTest < ActiveSupport::TestCase
  fixtures :doctors

   def test_doctor

      doctor_one = Doctor.new :full_name => doctors(:one).full_name, 
         :first_name => doctors(:one).first_name, 
         :middle_name => doctors(:one).middle_name, 
         :last_name => doctors(:one).last_name, 
	 :gender => doctors(:one).gender, 
	 :doctor_type_id => doctors(:one).doctor_type_id, 
	 :email => doctors(:one).email, 
	 :telephone => doctors(:one).telephone

	#assertion to test that saving a patient is successful
      assert doctor_one.save 

      doctor_one_copy = Doctor.find(doctor_one.id)

	#assrts that the patient_copy found is the needed read record-read a DB
      assert_equal doctor_one.full_name, doctor_one_copy.full_name

      doctor_one.full_name = "June Mary Ann"
	
	#asserts a successfull save after changing value
      assert doctor_one.save

	#asserts successfull deletion
      assert doctor_one.destroy
   end
end
