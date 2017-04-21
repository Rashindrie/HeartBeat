class Visit < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  ## validations ##

  validates :problems_complaints,  :presence => true,
                                  :length  => { :maximum => 255 }

  validates :diagnosis, :presence => true,
                        :length  => { :maximum => 255 }

  validates :drugs, :presence => true,
                    :length  => { :maximum => 255 }

  validates :remarks, :length  => { :maximum => 255 }

end
