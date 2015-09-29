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

    respond_with @nodes
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show
    render json: @node
  end

  # POST /nodes
  # POST /nodes.json
  def create
    @node = Node.new(node_params)

    if @node.save
      render json: @node, status: :created, location: @node
    else
      render json: @node.errors, status: :unprocessable_entity
    end
  end

  def sync
    stations = JSON.load(open("http://reisapi.ruter.no/Place/GetStopsRuter"))

    nodes = []

    stations.each do |station|
      coords = GeoUtm::UTM.new "32V", station["X"], station["Y"]
      coords = coords.to_lat_lon

      n = Node.find_or_create_by(name: station["Name"])

      n.y = coords.lon
      n.x = coords.lat
      n.save!

      nodes << n
    end

    respond_with nodes

  end

  private

    def set_node
      @node = Node.find(params[:id])
    end

    def node_params
      params[:node]
    end
end
