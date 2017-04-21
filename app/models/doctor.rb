class Doctor < ApplicationRecord
  has_one :user
  belongs_to :doctor_type
  has_many :vitals
  has_many :visits
  has_many :appointments
  has_many :time_slots
  has_many :organs_requester_patients

  validates :full_name, :presence => true,
            :length  => { :maximum => 255 }

  validates_presence_of :first_name
  validates_length_of :first_name, :maximum => 30
  validates_presence_of :last_name
  validates_length_of :last_name, :maximum => 50
  validates_presence_of :telephone
  validates_numericality_of :telephone
  validates_length_of :telephone, :within => 10..15


  scope :doctor_type, lambda { |q|
    where(:doctor_type_id => q)
  }

  scope :searchApp, lambda{|query|
    where(["full_name LIKE ?", "%#{query}%"])
  }


end
