class Doctor < ApplicationRecord
  has_one :user
  belongs_to :doctor_type
  has_many :vitals
  has_many :appointments
  has_many :time_slots

  validates_presence_of :full_name
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :gender
  validates_presence_of :email
  validates_presence_of :telephone

  scope :doctor_type, lambda { |q|
    where(:doctor_type_id => q)
  }

  scope :searchApp, lambda{|query|
    where(["full_name LIKE ?", "%#{query}%"])
  }


end
