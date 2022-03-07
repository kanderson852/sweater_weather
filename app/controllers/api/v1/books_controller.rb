class Api::V1::BooksController < ApplicationController
  def books_search
    books_list = BooksService.find_books(params[:location], params[:quantity])
    require "pry"; binding.pry
    render json: BooksSerializer.books(books_list, params[:location])
  end
end
