require 'rails_helper'

describe "Book search API" do
  it "sends a list of books", :vcr do


    get '/api/v1/book-search?location=denver,co&quantity=5'

    books_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(books_response).to be_a(Hash)
    expect(books_response).to have_key(:data)
    expect(books_response[:data]).to have_key(:attributes)
    expect(books_response[:data][:attributes][:destination]).to eq("denver,co")
    expect(books_response[:data][:attributes][:forecast]).to be_a(Hash)
    expect(books_response[:data][:attributes][:total_books_found]).to eq(41867)
    expect(books_response[:data][:attributes][:books].count).to eq(5)
    expect(books_response[:data][:attributes][:forecast]).to_not have_key(:humidity)
    expect(books_response[:data][:attributes][:books][0]).to_not have_key(:publish_date)
  end
end
