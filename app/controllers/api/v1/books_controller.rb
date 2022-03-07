class Api::V1::BooksController < ApplicationController
  def books_search
    books_list = BooksService.find_books(location = params[:q], quantity = params[:limit])
    render json: BooksSerializer.books(books_search, params[:location])
  end

  def query_params
    params.require(:location, :quantity)
  end
end
