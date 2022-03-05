require 'rails_helper'

describe "Backgrounds API" do
  it "sends background photo data", :vcr do

    headers = { 'Content-Type': 'application/json' }
    get '/api/v1/backgrounds?location=denver,co', headers: headers

    photo = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(photo).to be_a(Hash)
    expect(photo).to have_key(:data)
    expect(photo[:data]).to be_a(Hash)
    expect(photo[:data][:attributes]).to have_key(:image)
    expect(photo[:data][:attributes][:image]).to have_key(:location)
    expect(photo[:data][:attributes][:image][:location]).to eq('denver,co')
    expect(photo[:data][:attributes][:image]).to have_key(:image_url)
    expect(photo[:data][:attributes][:image][:image_url]).to eq('https://images.unsplash.com/photo-1594283606339-dd58534ebcf3?crop=entropy&cs=srgb&fm=jpg&ixid=MnwzMDc1NzV8MHwxfHNlYXJjaHwxfHwlMjB3ZWF0aGVyfGVufDB8fHx8MTY0NjUxNDE2Mw&ixlib=rb-1.2.1&q=85')
    expect(photo[:data][:attributes][:image]).to_not have_key(:description)
  end
end
