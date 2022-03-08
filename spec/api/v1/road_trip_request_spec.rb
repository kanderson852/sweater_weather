require 'rails_helper'

describe "Road Trip API" do
  it "makes a road trip", :vcr do
    user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

    headers = { 'Content-Type': 'application/json' }
    params = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": user.auth_token
    }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)
    road_trip = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    require "pry"; binding.pry
    expect(road_trip).to be_a(Hash)
  end
end
