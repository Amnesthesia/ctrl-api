require "open-uri"
require "json"
require "geoutm"

class NodesController < ApplicationController
  before_action :set_node, only: [:show, :update, :destroy]
  respond_to :json
  formats :json

  # GET /nodes
  # GET /nodes.json
  def index
    @nodes = Node.all

    respond_with ActiveModel::ArraySerializer.new(@nodes, each_serializer: NodeSerializer)
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show
    respond_with NodeSerializer.new(@node)
  end

  # POST /nodes
  # POST /nodes.json
  def create
    @node = Node.new(node_params)

    if @node.save
      respond_with NodeSerializer.new(@node)
    else
      render json: @node.errors, status: :unprocessable_entity
    end
  end

  def sync
    stations = JSON.load(open("http://reisapi.ruter.no/Place/GetStopsRuter"))

    nodes = []

    stations.each do |station|
      coords = GeoUtm::UTM.new "32N", station["X"], station["Y"]
      coords = coords.to_lat_lon

      if station["Name"] =~ /T-bane/
        n = Node.find_or_create_by(name: station["Name"], metro: true)
      else
        n = Node.find_or_create_by(name: station["Name"], metro: false)
      end


      n.y = coords.lon
      n.x = coords.lat
      n.save!

      nodes << n
    end

    respond_with ActiveModel::ArraySerializer.new(nodes, each_serializer: NodeSerializer)

  end

  def near
    current_location = Node.new(x: node_params[:x], y: node_params[:y])

    if node_params.has_key? "metro"
      if node_params[:metro] =~ /metro/
        nodes = Node.where(metro: true).within(5, origin: current_location)
      else
        nodes = Node.where(metro: false).within(5, origin: current_location)
      end
      else
      nodes = Node.within(5, origin: current_location)
    end


    respond_with ActiveModel::ArraySerializer.new(nodes, each_serializer: NodeSerializer)
  end

  def closest
    current_location = Node.new(x: node_params[:x], y: node_params[:y])

    if node_params.has_key? "metro"
      if node_params[:metro] =~ /metro/
        most_probable_nodes = Node.where(metro: true).closest(origin: current_location)
      else
        most_probable_nodes = Node.where(metro: false).closest(origin: current_location)
      end
    else
      most_probable_nodes = Node.closest(origin: current_location)
    end

    #most_probable_node = Node.within(0.2, origin: current_location).order('distance DESC')
    #most_probable_nodes = Node.closest(origin: current_location)


    respond_with ActiveModel::ArraySerializer.new(most_probable_nodes, each_serializer: NodeSerializer)
  end

  private

    def set_node
      @node = Node.find(params[:id])
    end

    def node_params
      params.permit(:x, :y, :format, :metro)
    end
end
