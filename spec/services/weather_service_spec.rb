require 'rails_helper'

RSpec.describe WeatherService, type: :service do
  context 'class methods' do
    describe '::conn' do
      it 'returns Faraday connection', :vcr do
        response = WeatherService.conn

        expect(response).to be_a(Faraday::Connection)
      end
    end

    describe '::get_weather', :vcr do
      it 'returns weather for a given lattitude and longitude' do
         weather = WeatherService.get_weather(39.738453, -104.984853)

         expect(weather).to be_a(Hash)
       end
     end
  end
end
