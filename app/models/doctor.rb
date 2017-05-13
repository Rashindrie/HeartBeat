class Doctor < ApplicationRecord
  has_one :user
  belongs_to :doctor_type
  has_many :vitals
  has_many :visits
  has_many :appointments
  has_many :time_slots
  has_many :organs_requester_patients

  REGEX = /[a-zA-Z]+/

  validates :full_name, :presence => true,
            :length  => { :maximum => 100 },
            format: { with: REGEX }

  validates :first_name, :presence => true,
            :length  => { :maximum => 30 },
            format: { with: REGEX }

  validates :middle_name,
            :length  => { :maximum => 30 }

  validates :last_name, :presence => true,
            :length  => { :maximum => 50 },
            format: { with: REGEX }


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
