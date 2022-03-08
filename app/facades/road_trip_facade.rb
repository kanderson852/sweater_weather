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
      weather_at_eta: weather_info(origin, destination)
    }

    RoadTrip.new(data)
  end

  def self.weather_info(origin, destination)
  end
end
