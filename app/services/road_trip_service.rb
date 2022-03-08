class RoadTripService
  def self.conn
    url = 'http://www.mapquestapi.com/directions/v2/'
    Faraday.new(url: url, params: { key: ENV['mapquest_key'] })
  end

  def self.get_directions(origin, destination)
    response = conn.get('route', { from: origin, to: destination})
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.formatted_data(origin, destination)
    trip = get_directions(origin, destination)

    if trip[:info][:messages][0] == "We are unable to route with the given locations."
      data =
      {
        travel_time: 'impossible',
        origin: origin,
        destination: destination,
        location: ''
      }
    else
      data =
      {
        travel_time: trip[:route][:formattedTime],
        origin: origin,
        destination: destination,
        location: trip[:route][:locations][1][:latLng]
      }
    end
  end
end
