class Patient::HomeController < ApplicationController
  layout 'application'
  before_action :confirm_logged_in
  before_action :require_patient

  def home
    @patient = Patient.joins(:user)
                   .select('patients.id AS id, first_name AS first_name,last_name AS last_name, users.email AS email')
                   .where('patient_id = ?',params[:id]).first

    #for appointment summary pie chart
    @app_scheduled=Appointment.app_patient_count(@patient.id, 1)
    @app_cancelled=Appointment.app_patient_count(@patient.id, 0)
    @wl=WaitingList.wl_patient_count(@patient.id)

    #for vital summary chart
    @data=Vital.where(:patient_id => @patient.id)
    @bld_pr= @data.pluck(:bld_pressure)
    @temp= @data.pluck(:temp)
    @pulse= @data.pluck(:pulse)
    @res_rate= @data.pluck(:res_rate)
    @from_date= @data.order('created_at').pluck(:created_at).first
    @to_date= @data.order('created_at DESC').pluck(:created_at).first
    @array = @bld_pr.each_with_index.map { |x,i| [ i+1, x, @temp[i], @pulse[i], @res_rate[i]] }

  end


end
