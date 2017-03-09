class PatientsController < ApplicationController

  def new
    @patient = Patient.new
  end

  def index

  end

  def create
    @patient= Patient.new(patient_params)

    if @patient.save
      flash[:notice] = "Patient created successfully."
      redirect_to('/')
    else
      render('new')  #to get a prepolutaed form
    end
  end

  def show

  end

  def edit

  end

  def delete

  end

  private

  def patient_params
    params.require(:patient).permit(:name,:postition,:visible)
  end
end
