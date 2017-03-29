class Staff < ApplicationRecord

  has_one :user
  has_many :time_slots

  validates_presence_of :full_name
end
