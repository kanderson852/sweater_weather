class Api::V1::ForecastController < ApplicationController
  def index
    forecast = WeatherFacade.location_forecast(params[:location])
    render json: ForecastSerializer.weather(forecast)
  end
end
