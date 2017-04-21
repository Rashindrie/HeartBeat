class Staff < ApplicationRecord

  has_one :user
  has_many :time_slots

  validates :full_name, :presence => true,
            :length  => { :maximum => 255 }

  validates_presence_of :first_name
  validates_length_of :first_name, :maximum => 30
  validates_presence_of :last_name
  validates_length_of :last_name, :maximum => 50
  validates_presence_of :telephone
  validates_numericality_of :telephone
  validates_length_of :telephone, :within => 10..15

end
