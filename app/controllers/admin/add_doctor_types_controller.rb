class Admin::AddDoctorTypesController < ApplicationController

  layout 'application'

  #validate authorized user
  before_action :confirm_logged_in
  before_action :require_admin

  #show index page to view doctor types
  def index
    @admin = User.find(params[:id])
    @doctor_types=DoctorType.all.order('speciality')
  end

  #add new doctor type
  def create
    @admin = User.find(params[:id])
    @doctor_types=DoctorType.all.order('speciality')
    @d=DoctorType.new(type_params)

    #render success if new type is valid
    if @d.valid?
      @d.save
      flash[:success] = "Doctor Type successfully added."
      redirect_to :controller => 'admin/add_doctor_types', :action => 'index', id: @admin.id
    else
      #flash.now[:error] = "Update unsuccessful." when update is unsuccessful
      @name = params[:type][:speciality]
      render('admin/add_doctor_types/index')
    end
  end

  #edit doctor types
  def update
    @admin = User.find(params[:admin_id])
    @doctor_types=DoctorType.all.order('speciality')
    @d=DoctorType.find(params[:id])

    #render success if update is successful
    if DoctorType.delete(params[:id])
      flash[:success] = "Doctor Type successfully deleted."
      redirect_to :controller => 'admin/add_doctor_types', :action => 'index', id: @admin.id
    else
      flash.now[:error] = "Update unsuccessful."
      @name = params[:type][:speciality]
      render('admin/add_doctor_types/index')
    end
  end

  #white listed parameters
  private
  def type_params
    params.require(:type).permit(:speciality)
  end
end
