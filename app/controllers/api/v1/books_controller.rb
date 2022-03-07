class Api::V1::BooksController < ApplicationController
  def books_search
    books_list = BooksService.find_books(params[:location], params[:quantity])
    forecast = WeatherFacade.location_forecast(params[:location])[:current]
    render json: BooksSerializer.books(books_list, params[:location], forecast)
  end
end
