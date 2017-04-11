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

  scope :doc_time_slots, ->(doctor_id, date, from_time,to_time) {
      where("from_time < ?", to_time).where("to_time > ?", from_time).from_date(date).from_doctor(doctor_id).count
  }


end
