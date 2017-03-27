class Vital < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  scope :newest_first, -> { order("created_at DESC") }

end
