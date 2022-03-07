require 'rails_helper'

describe "Users API" do
  it "makes a user", :vcr do

    headers = { 'Content-Type': 'application/json' }
    params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    post '/api/v1/users', headers: headers, params: JSON.generate(params)
    user = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(user).to have_key(:data)
    expect(user[:data]).to be_a(Hash)
    expect(user[:data]).to have_key(:attributes)
    expect(user[:data][:attributes][:email]).to eq("whatever@example.com")
  end

  it 'returns an error if passwords dont match', :vcr do
    headers = { 'Content-Type': 'application/json' }
    params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password2"
    }
    post '/api/v1/users', headers: headers, params: JSON.generate(params)

    expect(response).to have_http_status(404)
  end

  it 'cannot duplicate an email', :vcr do

    user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

    headers = { 'Content-Type': 'application/json' }
    params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    post '/api/v1/users', headers: headers, params: JSON.generate(params)

    invalid = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(invalid[:data][:message]).to eq('Invalid Email/Password')
  end

  it 'returns 404 when given invalid attributes', :vcr do
    params = {
      "email": "whatevergmail.com",
      "password": "password",
      "password_confirmation": "password"
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/users', headers: headers, params: JSON.generate(params)
    invalid = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(invalid[:data][:message]).to eq('Invalid Email/Password')
  end

  it 'cannot be missing a field', :vcr do
    headers = { 'Content-Type': 'application/json' }
    params = {
      "email": "whatever@example.com",
      "password": "password"
    }
    post '/api/v1/users', headers: headers, params: JSON.generate(params)

    expect(response).to have_http_status(404)
  end
end
