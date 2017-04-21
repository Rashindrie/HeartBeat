class Vital < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  scope :newest_first, -> { order("created_at DESC") }

  #### validations #####


  #validate_numericality_of - attribute must be integer or floating
  # equal_to,
  # greater_than,
  # less_than,
  # greater_than_or_equal_to,
  # less_than_or_equal_to,
  # odd,
  # even,
  # only_integer

  validates_numericality_of :height, :greater_than => 10.0  , :less_than => 272.0
  validates_numericality_of :weight, :greater_than => 0.0  , :less_than => 250.0
  validates_numericality_of :temp, :greater_than => 25.0  , :less_than => 43.0
  validates_numericality_of :pulse, :greater_than => 0.0 , :less_than => 230.0
  validates_numericality_of :res_rate, :greater_than => 0.0  , :less_than => 999.0
  validates_numericality_of :bld_pressure, :greater_than => 50.0 , :less_than => 250.0


end
