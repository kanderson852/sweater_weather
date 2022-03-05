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
  end
end
