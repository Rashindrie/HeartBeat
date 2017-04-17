class Organ < ApplicationRecord
  has_many :organs_donor_patients
  has_many :organs_requester_patients
  has_many :donor_patients, class_name: 'Patient', through: :organs_donor_patients,  :source => :patient
  has_many :requester_patients, class_name: 'Patient', through: :organs_requester_patients,  :source => :patient
end
