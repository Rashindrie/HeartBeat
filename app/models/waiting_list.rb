class WaitingList < ApplicationRecord
  belongs_to :patient
  belongs_to :time_slot

  scope :wl_patient_count, ->(id) {
    joins(:time_slot).where('patient_id = ?', id).count
  }

end
