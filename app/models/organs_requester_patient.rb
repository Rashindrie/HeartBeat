class OrgansRequesterPatient < ApplicationRecord

  belongs_to :organ
  belongs_to :patient
  belongs_to :doctor, optional: true

  validates :status,  :presence => true

end
