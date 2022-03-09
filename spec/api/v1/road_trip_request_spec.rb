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
    expect(road_trip).to be_a(Hash)
    expect(road_trip[:data][:attributes][:start_city]).to eq("Denver, Co")
    expect(road_trip[:data][:attributes][:end_city]).to eq("Pueblo, Co")
    expect(road_trip[:data][:attributes][:travel_time]).to eq("01 hours, 45 minutes")
    expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
  end

  it "makes a road trip with impossible destination", :vcr do
    user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

    headers = { 'Content-Type': 'application/json' }
    params = {
      "origin": "Denver,CO",
      "destination": "London,UK",
      "api_key": user.auth_token
    }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)
    road_trip = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(road_trip).to be_a(Hash)
    expect(road_trip[:data][:attributes][:start_city]).to eq("Denver, Co")
    expect(road_trip[:data][:attributes][:end_city]).to eq("London, Uk")
    expect(road_trip[:data][:attributes][:travel_time]).to eq("impossible")
    expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(String)
  end

  it 'can travel more than 24 hours', :vcr do
    user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

    headers = { 'Content-Type': 'application/json' }
    params = {
      "origin": "New York,NY",
      "destination": "Las Angeles,CA",
      "api_key": user.auth_token
    }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)
    road_trip = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(road_trip).to be_a(Hash)
    expect(road_trip[:data][:attributes][:start_city]).to eq("New York, Ny")
    expect(road_trip[:data][:attributes][:end_city]).to eq("Las Angeles, Ca")
    expect(road_trip[:data][:attributes][:travel_time]).to eq("40 hours, 16 minutes")
    expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
    expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to eq(60.85)
  end

  it 'requires an api key' do

    headers = { 'Content-Type': 'application/json' }
    params = {
      "origin": "Denver,CO",
      "destination": "London,UK",
      "api_key": ''
    }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)
    road_trip = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(road_trip).to eq({ data: { message: 'Invalid API key' } })
  end
end
