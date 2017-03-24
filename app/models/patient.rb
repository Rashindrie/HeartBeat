class Patient < ApplicationRecord


  scope :newest_first, -> { order("created_at DESC").limit(1)}
  #scope :search, -> {|query| where(["name LIKE ?", "%#{query}%"])}

end
