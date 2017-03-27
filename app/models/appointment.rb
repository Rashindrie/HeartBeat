class Appointment < ApplicationRecord

  belongs_to :patients
  belongs_to :time_slots

end
