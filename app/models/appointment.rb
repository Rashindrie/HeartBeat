class Appointment < ApplicationRecord

  belongs_to :patient
  belongs_to :time_slot

  validates :patient, :presence => true
  validates :time_slot, :presence => true



  scope :countApp, lambda { |q|
    where(:time_slot_id => q).count
  }


end
