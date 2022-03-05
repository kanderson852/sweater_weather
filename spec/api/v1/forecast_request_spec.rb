require 'rails_helper'

describe "Forecast API" do
  it "sends forecast data", :vcr do

    headers = { 'Content-Type': 'application/json' }
    get '/api/v1/forecast?location=denver,co', headers: headers

    weather = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(weather).to be_a(Hash)
    expect(weather).to have_key(:data)
    expect(weather[:data]).to be_a(Hash)
    expect(weather[:data][:attributes]).to be_a(Hash)
    expect(weather[:data][:attributes]).to have_key(:current_weather)
    expect(weather[:data][:attributes]).to have_key(:daily_weather)
    expect(weather[:data][:attributes]).to have_key(:hourly_weather)
    expect(weather[:data][:attributes]).to_not have_key(:minutely_weather)
    expect(weather[:data][:attributes][:current_weather]).to have_key(:sunrise)
    expect(weather[:data][:attributes][:current_weather]).to_not have_key(:pressure)
   end
 end
