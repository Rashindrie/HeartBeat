class Patient::HomeController < ApplicationController
  layout 'application'
  protect_from_forgery unless: -> { request.format.html? }

  def home
    @patient = Patient.find(params[:id])
  end


end
