class Doctor < ApplicationRecord
  belongs_to :doctor_type
  has_many :vitals
end
