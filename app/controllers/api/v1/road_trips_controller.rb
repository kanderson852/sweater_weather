class Api::V1::RoadTripsController < ApplicationController
  def create
    user = User.find_by(auth_token: params[:api_key])
    if user != nil
      trip = RoadTripFacade.road_trip(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(trip)
    else
      return invalid_credentials
    end
  end

private
  def road_trip_params
    params.permit( :start_city,
                :end_city,
                :travel_time,
                :weather_at_eta,
                :id)
  end

  def invalid_credentials
    render json: { data: { message: 'Invalid API key' } }
  end
end
