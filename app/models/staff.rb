class Staff < ApplicationRecord

  has_one :user
  has_many :time_slots
end
