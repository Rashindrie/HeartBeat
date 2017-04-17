class OrgansDonorPatient < ApplicationRecord

  belongs_to :organ
  belongs_to :patient


  validates :category, :inclusion => { :in => [true, false] }
end
