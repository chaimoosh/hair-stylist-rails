class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.all
  end

  def new
    @appointment = Appointment.new(user_id: session[:user_id])
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.user = User.find_by(id: session[:user_id])
    if @appointment.save
      binding.pry
      redirect_to appointment_path(@appointment)
    else
      render :new
    end
  end

  def show
    @appointment = Appointment.find_by(id: params[:id])
  end

  def edit
    @appointment = Appointment.find_by(id: params[:id])
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


  private

  def appointment_params
    params.require(:appointment).permit(:time, :service_id)
  end
end
