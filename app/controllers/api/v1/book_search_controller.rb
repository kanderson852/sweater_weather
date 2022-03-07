class Api::V1::BookSearchController < ApplicationController
  def index
    books_list = BooksService.find_books(params[:q], params[:])
    render json: PhotoSerializer.image(image, params[:location])
  end
end
