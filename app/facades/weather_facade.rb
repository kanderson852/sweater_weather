class WeatherFacade
  def self.location_forecast(location)
    location = MapquestService.get_lat_long(location)
    WeatherService.get_weather(location[:lat], location[:lng])
  end
end
