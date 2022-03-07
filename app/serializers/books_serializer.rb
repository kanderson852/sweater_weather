class BooksSerializer

  def self.books(books_list, location, forecast)
        {
      "data": {
        "id": "null",
        "type": "books",
        "attributes": {
          "destination": location,
          "forecast": {
            "summary": forecast[:weather][0][:description],
            "temperature": forecast[:temp]
          },
          "total_books_found": books_list[:numFound],
          "books": books_list[:docs].map do |book|
            {
              "isbn": book[:isbn],
              "title": book[:title],
              "publisher": book[:publisher]
            }
          end,
        }
      }
    }
  end
end
