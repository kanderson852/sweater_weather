class RoadTripService
  def self.conn
    url = 'http://www.mapquestapi.com/directions/v2/'
    Faraday.new(url: url, params: { key: ENV['mapquest_key'] })
  end

  def self.get_directions(origin, destination)
    response = conn.get('route', { from: origin, to: destination})
    JSON.parse(response.body, symbolize_names: true)
  end
end
