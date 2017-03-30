class TimeSlot < ApplicationRecord
  belongs_to :doctor
  belongs_to :staff
  has_many :appointments


  scope :from_date, lambda { |q|
    where(:app_date => q)
  }

  scope :from_doctor, lambda { |q|
    where(:doctor_id => q)
  }

  scope :valid_slots, lambda { |q|

  }


end
