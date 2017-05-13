class Staff < ApplicationRecord

  has_one :user
  has_many :time_slots

  REGEX = /\A[[:alpha:][:blank:]]+\z/
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

end
