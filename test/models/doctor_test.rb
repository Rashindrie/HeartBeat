require 'test_helper'

class DoctorTest < ActiveSupport::TestCase
  fixtures :doctors

   def test_doctor

	doctor_two = Doctor.new :full_name => doctors(:two).full_name, 
		 :first_name => doctors(:two).first_name, 
		 :middle_name => doctors(:two).middle_name, 
		 :last_name => doctors(:two).last_name, 
		 :gender => doctors(:two).gender, 
		 :doctor_type_id => doctors(:two).doctor_type_id, 
		 :email => doctors(:two).email, 
		 :telephone => doctors(:two).telephone

	#assertion to test that saving a doctor is successful
      assert doctor_two.save 

      doctor_one = Doctor.new :full_name => doctors(:one).full_name, 
         :first_name => doctors(:one).first_name, 
         :middle_name => doctors(:one).middle_name, 
         :last_name => doctors(:one).last_name, 
	 :gender => doctors(:one).gender, 
	 :doctor_type_id => doctors(:one).doctor_type_id, 
	 :email => doctors(:one).email, 
	 :telephone => doctors(:one).telephone

	#assertion to test that saving a doctor is successful
      assert doctor_one.save 


      doctor_one_copy = Doctor.find(doctor_one.id)

	#assrts that the doctor_copy found is the needed read record-read a DB
      assert_equal doctor_one.full_name, doctor_one_copy.full_name

      doctor_one.full_name = "June Mary Ann"
	
	#asserts a successfull save after changing value
      assert doctor_one.save

	#asserts successfull deletion
      assert doctor_one.destroy
   
	

	end

	test "should not save doctor without full_name" do
	  doctor_wrong = Doctor.new
	  assert_not doctor_wrong.save
	end

	test "should not save doctor without first_name" do
		  doctor_wrong = Doctor.new
		  assert_not doctor_wrong.save
		end

	test "should not save doctor without last_name" do
		  doctor_wrong = Doctor.new
		  assert_not doctor_wrong.save
		end

	test "should not save doctor without email" do
		  doctor_wrong = Doctor.new
		  assert_not doctor_wrong.save
		end

end
