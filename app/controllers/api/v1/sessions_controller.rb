class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    return invalid_credentials if user.nil?
    if user.authenticate(params[:password])
      render json: SessionsSerializer.sessions_data(user)
    end
  end

private
  def invalid_credentials
    render json: { data: { message: 'Invalid Email/Password' } }
  end
end
