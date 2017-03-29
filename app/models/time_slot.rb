class TimeSlot < ApplicationRecord
  belongs_to :doctor
  belongs_to :staff
  has_many :appointments


  scope :fromdate, lambda { |q|
    where(:app_date => q)
  }

  scope :fromdoctor, lambda { |q|
    where(:doctor_id => q).where('app_date >= ?', Date.today)
  }




end
