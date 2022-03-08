class RoadTripFacade
  def self.road_trip(origin, destination)
    trip = RoadTripService.formatted_data(origin, destination)
    time = trip[:travel_time]
    hours = time.slice(0..1)
    minutes = time.slice(3..4)
    data = {
      start_city: origin,
      end_city: destination,
      travel_time: "#{hours} hours, #{minutes} minutes",
      weather_at_eta: weather_info(origin, destination, hours)
    }

    RoadTrip.new(data)
  end

  def self.weather_info(origin, destination, hours)
    weather = WeatherFacade.location_forecast(destination)
    data =
    {
      temperature: weather[:hourly][hours.to_i][:temp],
      conditions: weather[:hourly][hours.to_i][:weather][0][:description]
    }
  end
end
