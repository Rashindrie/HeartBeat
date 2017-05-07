class DoctorType < ApplicationRecord
  has_many :doctors

  scope :sorted, -> { order("speciality ASC") }

  REGEX = /[a-zA-Z]+/

  validates :speciality,
            presence: true,
            length: { maximum: 100 },
            format: { with: REGEX },
            uniqueness: { case_sensitive: false }
end
