class Doctor < ApplicationRecord
  has_one :user
  belongs_to :doctor_type
  has_many :vitals
  has_many :appointments
  has_many :time_slots

  scope :doctor_type, lambda { |q|
    where(:doctor_type_id => q)
  }

  scope :search, lambda{|query|
    where(["full_name LIKE ?", "%#{query}%"])
  }


end
