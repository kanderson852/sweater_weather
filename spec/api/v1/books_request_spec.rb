require 'rails_helper'

describe "Book search API" do
  it "sends a list of books", :vcr do


    get '/api/v1/book-search?location=denver,co&quantity=5'

    books = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(books).to be_a(Hash)
  end
end
