class AppointmentsController < ApplicationController
  before_action :require_login
  def index
    @user = User.find_by(id: session[:user_id])
    if @user.admin == true
      @appointments = Appointment.all
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @appointments }
      end
    else
      @appointments = @user.appointments
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @appointments}
      end
    end
  end

  def new
    @appointment = Appointment.new(user_id: session[:user_id])
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.user = User.find_by(id: session[:user_id])
    if @appointment.save
      redirect_to appointment_path(@appointment)
    else
      render :new
    end
  end

  def show
    @appointment = Appointment.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: session[:user_id])
    @appointment = Appointment.find_by(id: params[:id])
    if @user.admin == false && @appointment.user_id != @user.id
      flash[:notice] = "You don't have access to that page"
      redirect_to appointments_path
    end
  end

  def update
    @appointment = Appointment.find_by(id: params[:id])
    if @appointment.update(appointment_params)
      redirect_to appointment_path(@appointment)
    else
      render :edit
    end
  end

  def destroy
    @appointment = Appointment.find_by(id: params[:id])
    @appointment.destroy
    redirect_to appointments_path
  end

  def overdue_appointments
    @appointments = Appointment.overdue_appointments(Time.now)
  end
  private

  def appointment_params
    params.require(:appointment).permit(:time, :service_id)
  end
end
