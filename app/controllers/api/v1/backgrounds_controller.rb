class Api::V1::BackgroundsController < ApplicationController
  def index
    image = PhotoService.find_image(params[:query])
    render json: PhotoSerializer.image(image, params[:location])
  end
end
