class TimeSlot < ApplicationRecord
  belongs_to :doctor
  belongs_to :staff
  has_many :appointments


  scope :from_date, lambda { |q|
    where(:app_date => q)
  }

  scope :from_doctor, lambda { |q|
    where(:doctor_id => q)
  }

  scope :doc_time_slots, ->(doctor_id, date, from_time,to_time) {
      where("from_time < ?", to_time).where("to_time > ?", from_time).from_date(date).from_doctor(doctor_id).count
  }

  validates :from_time, :presence => true

  validates :to_time, :presence => true

  validates :app_date, :presence => true

  validate :to_time_should_be_after_from_time

  def to_time_should_be_after_from_time
    if to_time.present? && from_time.present? && (to_time <= from_time + 29.minutes)
      errors.add(:to_time, "should be at least 30 mins after From time")
    end
  end

  def start_time
    app_date.to_datetime
  end
end
