class Patient < ApplicationRecord

  has_one :user
  has_many :vitals
  has_many :visits
  has_many :appointments
  has_many :waiting_lists
  has_many :organs_donor_patients
  has_many :organs_requester_patients
  has_many :donor_organs, class_name: 'Organ', through: :organs_donor_patients,  :source => :organ
  has_many :requester_organs, class_name: 'Organ', through: :organs_requester_patients,  :source => :organ

  scope :newest_first, -> { order("created_at DESC").limit(1)}

  ###### validations ######

  REGEX = /[a-zA-Z]+/


  validates :full_name, :presence => true,
            :length  => { :maximum => 100 },
            format: { with: REGEX }

  validates :first_name, :presence => true,
            :length  => { :maximum => 30 },
            format: { with: REGEX }

  validates :middle_name,
            :length  => { :maximum => 30 }

  validates :last_name, :presence => true,
            :length  => { :maximum => 50 },
            format: { with: REGEX }

  validates_presence_of :telephone
  validates :telephone, numericality: { only_integer: true, message: "is invalid" }
  validates_length_of :telephone, :within => 10..15
  validates_presence_of :date_of_birth
  validates :registered, :inclusion => { :in => [true, false] }


end


#validates_presence_of = that attribute is not blank(nil, false, "", " ", [], {})
#validates_length_of = that attribute is of certain length(is, within, minimum, maximum, in) - would allow spaces
#validate_numericality_of - attribute must be integer or floating(equal_to, greater_than, less_than, greater_than_or_equal_to, less_than_or_equal_to, odd, even, only_integer)
#validates_inclusion_of-attr must be in a list of choices-array/range (:in)
#validates_exclusion_of - opp of above
#format_of -att must match with a regular exp (:with) email and url
#uniqueness_of  -attr is unique in db (case_sensitive, scope(admin/doctor))
       #add a scope :scope => :subject_id (in user table)-each subject should have unique patient. but diff subject can hae the same patiens
#validates_acceptance_of
#validates_confirmation_of (asking to enter data twice) (email_confirmation and email has to match)
#validates_associated-associated ob or obj are validated


#:allow_nil => true skip validations if nil
#:allow_blank => skip if blank
# :on => :save/:create/:update/
#:if => :method/ :unless => :method
