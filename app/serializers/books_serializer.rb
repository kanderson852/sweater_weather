class BooksSerializer

  def self.books(books_list, location)
    require "pry"; binding.pry
        {
      "data": {
        "id": "null",
        "type": "books",
        "attributes": {
          "destination": "denver,co",
          "forecast": {
            "summary": "Cloudy with a chance of meatballs",
            "temperature": "83 F"
          },
          "total_books_found": 172,
          "books": [
            {
              "isbn": [
                "0762507845",
                "9780762507849"
              ],
              "title": "Denver, Co",
              "publisher": [
                "Universal Map Enterprises"
              ]
            },
            {
              "isbn": [
                "9780883183663",
                "0883183668"
              ],
              "title": "Photovoltaic safety, Denver, CO, 1988",
              "publisher": [
                "American Institute of Physics"
              ]
            }
          ]
        }
      }
    }
  end
end
