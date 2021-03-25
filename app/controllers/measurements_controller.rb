class MeasurementsController < ApplicationController
  before_action :set_measurement, only: [:show, :update, :destroy]

  # GET /measurements
  def index
    @measurements = Measurement.all
    json_response(@measurements)
  end

  # POST /measurements
  def create
    @measurement = Measurement.create!(measurement_params)
    @measurement.save
    json_response(@measurement, :created)
  end

  # GET /measurements/:id
  def show
    json_response(@measurement)
  end

  # PUT /measurements/:id
  def update
    @measurement.update(measurement_params)
    head :no_content
  end

  # DELETE /measurements/:id
  def destroy
    @measurement.destroy
    head :no_content
  end

  private

  def measurement_params
    # whitelist params
    params.permit(:name, :created_by)
  end

  def set_measurement
    @measurement = Measurement.find(params[:id])
  end
end