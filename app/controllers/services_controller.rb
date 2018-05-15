class ServicesController < ApplicationController
  before_action :admin
  def index
    @services = Service.all
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.create(service_params)
    redirect_to service_path(@service)
  end

  def show
    @service = Service.find_by(id: params[:id])
  end

  def edit
    @service = Service.find_by(id: params[:id])
  end

  def update
    @service = Service.find_by(id: params[:id])
    @service.update(service_params)
    redirect_to service_path(@service)
  end

  def delete
    @service = Service.find_by(id: params[:id])
    @service.destroy
  end

  private

  def service_params
    params.require(:service).permit(:name, :price)
  end
end
