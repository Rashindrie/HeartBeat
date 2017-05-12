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
	 :registered => patients(:one).registered, 
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

	test "should not save registered patient without full_name" do
	  patient_wrong = Patient.new
	  patient_wrong.first_name="Jane"
	  patient_wrong.middle_name="Doe"
	  patient_wrong.last_name="Ferdinando"
	  patient_wrong.date_of_birth="1999-02-18"
	  patient_wrong.telephone=0111111111
	  patient_wrong.registered=1
	  patient_wrong.gender=1
	  assert_not patient_wrong.save
	end

	test "should not save unregistered patient without full_name" do
	  patient_wrong = Patient.new
	  patient_wrong.first_name="Jane"
	  patient_wrong.middle_name="Doe"
	  patient_wrong.last_name="Ferdinando"
	  patient_wrong.date_of_birth="1999-02-18"
	  patient_wrong.telephone=0111111111
	  patient_wrong.registered=0
	  patient_wrong.gender=1
	  assert_not patient_wrong.save
	end

	test "should not save registered patient without first_name" do
	  patient_wrong = Patient.new
	  patient_wrong.full_name="Jane Doe Ferdinando"
	  patient_wrong.middle_name="Doe"
	  patient_wrong.last_name="Ferdinando"
	  patient_wrong.date_of_birth="1999-02-18"
	  patient_wrong.telephone=0111111111
	  patient_wrong.registered=1
	  patient_wrong.gender=1
	  assert_not patient_wrong.save
	end

	test "should not save unregistered patient without first_name" do
	  patient_wrong = Patient.new
	  patient_wrong.full_name="Jane Doe Ferdinando"
	  patient_wrong.middle_name="Doe"
	  patient_wrong.last_name="Ferdinando"
	  patient_wrong.date_of_birth="1999-02-18"
	  patient_wrong.telephone=0111111111
	  patient_wrong.registered=0
	  patient_wrong.gender=1
	  assert_not patient_wrong.save
	end

	test "should not save registered patient without last_name" do
	  patient_wrong = Patient.new
	  patient_wrong.full_name="Jane Doe Ferdinando"
	  patient_wrong.middle_name="Doe"
	  patient_wrong.first_name="Jane"
	  patient_wrong.date_of_birth="1999-02-18"
	  patient_wrong.telephone=0111111111
	  patient_wrong.registered=1
	  patient_wrong.gender=1
	  assert_not patient_wrong.save
	end

	test "should not save unregistered patient without last_name" do
	  patient_wrong = Patient.new
	  patient_wrong.full_name="Jane Doe Ferdinando"
	  patient_wrong.middle_name="Doe"
	  patient_wrong.first_name="Jane"
	  patient_wrong.date_of_birth="1999-02-18"
	  patient_wrong.telephone=0111111111
	  patient_wrong.registered=0
	  patient_wrong.gender=1
	  assert_not patient_wrong.save
	end
end
