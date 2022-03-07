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

    user_params = {
      "email": "whatever@example.com",
      "password": "password"
    }

    post '/api/v1/sessions', headers: headers, params: JSON.generate(user_params)
    session = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(session[:data][:attributes][:email]).to eq("whatever@example.com")
  end

  it 'Returns an error message if email is wrong' do
    user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

    user_params = {
      "email": "wrong@example.com",
      "password": "password"
    }
    post '/api/v1/sessions', headers: headers, params: JSON.generate(user_params)
    invalid = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(invalid[:data][:message]).to eq('Invalid Email/Password')
  end

  it 'Returns an error message if password is wrong' do
    user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

    user_params = {
      "email": "whatever@example.com",
      "password": "wrong password"
    }
    post '/api/v1/sessions', headers: headers, params: JSON.generate(user_params)
    invalid = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(invalid[:data][:message]).to eq('Invalid Email/Password')
  end

end
