require 'rails_helper'

RSpec.describe BooksService, type: :service do
  context 'class methods' do
    describe '::conn' do
      it 'returns Faraday connection', :vcr do
        response = BooksService.conn

        expect(response).to be_a(Faraday::Connection)
      end
    end

    describe '::find_book' do
      it 'returns books related to a destination', :vcr do
         books = BooksService.find_books("Denver,CO", 5)

         expect(books).to be_a(Hash)
         expect(books).to have_key(:docs)
         expect(books[:docs].count).to eq(5)
       end
     end
  end
end
