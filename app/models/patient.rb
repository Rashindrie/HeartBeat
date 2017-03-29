class Patient < ApplicationRecord

  has_one :user
  has_many :vitals
  has_many :appointments

  validates_presence_of :full_name

  scope :newest_first, -> { order("created_at DESC").limit(1)}
  #scope :search, -> {|query| where(["name LIKE ?", "%#{query}%"])}

end
