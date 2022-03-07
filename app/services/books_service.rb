class BooksService
  def self.conn
    url = 'http://openlibrary.org/'
    Faraday.new(url: url)
  end

  def self.find_books(location, quantity)
    response = conn.get('search.json', { q: location, limit: quantity})
    JSON.parse(response.body, symbolize_names: true)
  end
end
