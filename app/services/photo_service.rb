class PhotoService
  def self.conn
    url = 'https://api.unsplash.com/'
    Faraday.new(url: url, params: { client_id: ENV['image_key'] })
  end

  def self.find_image(location)
    response = conn.get('search/photos', { query: "#{location} weather"})
    a = JSON.parse(response.body, symbolize_names: true)[:results][0]
  end
end
