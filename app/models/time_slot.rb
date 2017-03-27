class TimeSlot < ApplicationRecord

  scope :fromdate, lambda { |q|
    where(:app_date => q)
  }


end
