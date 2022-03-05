require 'rails_helper'

RSpec.describe WeatherFacade, type: :facade do
  context 'class methods' do
    describe '::location_forecast', :vcr do
      it 'should return forecast data' do
        forecast = WeatherFacade.location_forecast('denver,co')

        expect(forecast).to be_a(Hash)
      end
    end
  end
end
