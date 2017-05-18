class Admin::AddDoctorTypesController < ApplicationController

  layout 'application'

  before_action :confirm_logged_in
  before_action :require_admin

  def index
    @admin = User.find(params[:id])
    @doctor_types=DoctorType.all.order('speciality')
  end

  def create
    @admin = User.find(params[:id])
    @doctor_types=DoctorType.all.order('speciality')
    @d=DoctorType.new(type_params)

    if @d.valid?
      @d.save
      flash[:success] = "Doctor Type successfully added."
      redirect_to :controller => 'admin/add_doctor_types', :action => 'index', id: @admin.id
    else
      #flash.now[:error] = "Update unsuccessful."
      @name = params[:type][:speciality]
      render('admin/add_doctor_types/index')
    end
  end

  def update
    @admin = User.find(params[:admin_id])
    @doctor_types=DoctorType.all.order('speciality')
    @d=DoctorType.find(params[:id])

    if DoctorType.delete(params[:id])
      flash[:success] = "Doctor Type successfully deleted."
      redirect_to :controller => 'admin/add_doctor_types', :action => 'index', id: @admin.id
    else
      flash.now[:error] = "Update unsuccessful."
      @name = params[:type][:speciality]
      render('admin/add_doctor_types/index')
    end
  end

  private
  def type_params
    params.require(:type).permit(:speciality)
  end
end
