class Api::V1::BooksController < ApplicationController
  def books_search
    if params[:quantity].to_i > 0
      books_list = BooksService.find_books(params[:location], params[:quantity])
      forecast = WeatherFacade.location_forecast(params[:location])[:current]
      render json: BooksSerializer.books(books_list, params[:location], forecast)
    else
      render status: 404
    end
  end
end
