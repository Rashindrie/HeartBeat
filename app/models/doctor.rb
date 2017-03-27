class Doctor < ApplicationRecord
  belongs_to :doctor_type
  has_many :vitals

  scope :doctor_type, lambda { |q|
    where(:doctor_type_id => q)
  }

  scope :search, lambda{|query|
    where(["full_name LIKE ?", "%#{query}%"])
  }


end
