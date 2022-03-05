class MapquestService
  def self.conn
    url = 'http://www.mapquestapi.com/geocoding/v1/'
    Faraday.new(url: url, params: { key: ENV['mapquest_key'] })
  end

  def self.get_lat_long(string)
    response = conn.get('address', { location: string})
    JSON.parse(response.body, symbolize_names: true)[:results][0][:locations][0][:latLng]
  end
end
