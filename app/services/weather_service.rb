class WeatherService
  def self.conn
    url = 'https://api.openweathermap.org/data/2.5/'
    Faraday.new(url: url, params: { appid: ENV['weather_key']})
  end

  def self.get_weather(lat, lon)
    response = conn.get('onecall', { lat: lat, lon: lon, exclude: 'minutely,alerts'})
    a = JSON.parse(response.body, symbolize_names: true)
  end
end
