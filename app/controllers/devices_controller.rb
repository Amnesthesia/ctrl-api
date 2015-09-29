class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :update, :destroy]

  # GET /devices
  # GET /devices.json
  def index
    @devices = Device.all

    render json: @devices
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
    render json: @device
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)

    if @device.save
      render json: @device, status: :created, location: @device
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    @device = Device.find(params[:id])

    if @device.update(device_params)
      head :no_content
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy

    head :no_content
  end

  private

    def set_device
      @device = Device.find(params[:id])
    end

    def device_params
      params[:device]
    end
end
