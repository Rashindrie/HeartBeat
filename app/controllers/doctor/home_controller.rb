class Doctor::HomeController < ApplicationController
  layout 'application'
  before_action :confirm_logged_in
  before_action :require_doctor

  #show doctor home
  def home
    @doctor = Doctor.find(params[:id])
    @doctor_type = DoctorType.find(@doctor.doctor_type_id)



    #app_summary_by_day chart
    @sun=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('DAYOFWEEK(time_slots.app_date) = 1').count
    @mon=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('DAYOFWEEK(time_slots.app_date) = 2').count
    @tue=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('DAYOFWEEK(time_slots.app_date) = 3').count
    @wed=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('DAYOFWEEK(time_slots.app_date) = 4').count
    @thur=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('DAYOFWEEK(time_slots.app_date) = 5').count
    @fri=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('DAYOFWEEK(time_slots.app_date) = 6').count
    @sat=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('DAYOFWEEK(time_slots.app_date) = 7').count


    #app_summary_by_month
    @jan=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 1').count
    @feb=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 2').count
    @mar=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 3').count
    @apr=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 4').count
    @may=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 5').count
    @jun=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 6').count
    @jul=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 7').count
    @aug=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 8').count
    @sep=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 9').count
    @oct=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 10').count
    @nov=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 11').count
    @dec=Appointment.joins(:time_slot).where('time_slots.doctor_id = ?',params[:id] ).where('MONTH(time_slots.app_date) = 12').count

    #task-card
    @time_slot=TimeSlot.where('doctor_id = ?', params[:id]).where('app_date = ?', Date.today.to_date )


    #organ requests
    @requests=OrgansRequesterPatient.where('status = 0').count


  end


end