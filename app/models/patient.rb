class Patient < ApplicationRecord

  has_one :user
  has_many :vitals
  has_many :visits
  has_many :appointments
  has_many :waiting_lists

  validates_presence_of :full_name

  scope :newest_first, -> { order("created_at DESC").limit(1)}
  #scope :searchApp, -> {|query| where(["name LIKE ?", "%#{query}%"])}

  has_many :organs_donor_patients
  has_many :organs_requester_patients
  has_many :donor_organs, class_name: 'Organ', through: :organs_donor_patients,  :source => :organ
  has_many :requester_organs, class_name: 'Organ', through: :organs_requester_patients,  :source => :organ

end
