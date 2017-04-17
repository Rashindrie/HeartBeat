class Appointment < ApplicationRecord

  belongs_to :patient
  belongs_to :time_slot

  validates :patient, :presence => true
  validates :time_slot, :presence => true



  scope :countApp, lambda { |q|
    where(:time_slot_id => q).count
  }

  scope :existingApp, ->(patient_id, time_slot_id) {
    where("patient_id = ?", patient_id).where("time_slot_id = ?", time_slot_id).count
  }


  scope :countApp, lambda { |q|
    where(:time_slot_id => q).count
  }


  scope :app_patient_count, ->(id, status) {
    joins(:time_slot).where('appointments.status = ?', status).where('patient_id = ?', id).count
  }

end
