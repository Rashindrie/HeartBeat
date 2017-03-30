require 'test_helper'

class PatientTest < ActiveSupport::TestCase
 fixtures :patients

   def test_patient

      patient_one = Patient.new :full_name => patients(:one).full_name, 
         :first_name => patients(:one).first_name, 
         :middle_name => patients(:one).middle_name, 
         :last_name => patients(:one).last_name, 
	 :gender => patients(:one).gender, 
	 :date_of_birth => patients(:one).date_of_birth, 
	 :email => patients(:one).email, 
	 :telephone => patients(:one).telephone

	#assertion to test that saving a patient is successful
      assert patient_one.save 

      patient_one_copy = Patient.find(patient_one.id)

	#assrts that the patient_copy found is the needed read record-read a DB
      assert_equal patient_one.full_name, patient_one_copy.full_name

      patient_one.full_name = "June Mary Ann"
	
	#asserts a successfull save after changing value
      assert patient_one.save

	#asserts successfull deletion
      assert patient_one.destroy


   end

	test "should not save patient without full_name" do
	  patient_wrong = Patient.new
	  assert_not patient_wrong.save
	end

test "should not save patient without first_name" do
	  patient_wrong = Patient.new
	  assert_not patient_wrong.save
	end

test "should not save patient without last_name" do
	  patient_wrong = Patient.new
	  assert_not patient_wrong.save
	end
end
