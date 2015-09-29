class ControlsController < ApplicationController

  respond_to :json
  formats :json
  # GET /controls
  # GET /controls.json
  def index
    @controls = Control.all

    respond_with @controls
  end


  # POST /controls
  # POST /controls.json
  def create
    @control = Control.new(control_params)

    current_location = Node.new(x: control_params[:x], y: control_params[:y])

    #most_probable_node = Node.within(0.2, origin: current_location).order('distance DESC')
    most_probable_node = Node.closest(origin: current_location)

    @control.node = most_probable_node

    if not most_probable_node
      render json: {message: "Fant ikke noen stasjon i området"}, status: :bad_request
    elsif @control.save and Control.where(node: most_probable_node,
                                          device: Device.find_by_uuid(control_params[:uuid]),
                                          created_at: DateTime.now..DateTime.now - 1.hour,
                                          is_active: control_params[:active_state]).count < 1
      respond_with @control
    else
      render json: @control.errors, status: :unprocessable_entity
    end
  end

  private

  def control_params
    params.require(:control).permit(:x, :y, :uuid, :active_state)
  end

end
