class DoctorType < ApplicationRecord
  has_many :doctors

  scope :sorted, -> { order("speciality ASC") }

end
