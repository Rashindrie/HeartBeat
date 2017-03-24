class Vital < ApplicationRecord
  belongs_to :doctor
  scope :newest_first, -> { order("created_at DESC") }

end
