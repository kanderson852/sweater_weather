require 'rails_helper'

RSpec.describe RoadTripFacade, type: :facade do
  context 'class methods' do
    describe '::road_trip', :vcr do
      it 'should return road trip data' do
        trip = RoadTripFacade.road_trip('denver,co', 'pueblo,co')

        expect(trip).to be_a(RoadTrip)
        expect(trip.id).to eq(nil)
        expect(trip.start_city).to eq('Denver, Co')
        expect(trip.end_city).to eq('Pueblo, Co')
        expect(trip.travel_time).to eq("01 hours, 45 minutes")
        expect(trip.weather_at_eta).to eq({temperature: 39.6 , conditions: "clear sky"})
      end

      it 'returns impossible if given an invalid trip', :vcr do
        trip = RoadTripFacade.road_trip('denver,co', 'london,uk')

        expect(trip).to be_a(RoadTrip)
        expect(trip.id).to eq(nil)
        expect(trip.start_city).to eq('Denver, Co')
        expect(trip.end_city).to eq('London, Uk')
        expect(trip.travel_time).to eq("impossible")
        expect(trip.weather_at_eta).to eq('')
      end
    end

    describe '::weather_info', :vcr do
      it 'finds the weather given a destination' do
        weather = RoadTripFacade.weather_info('denver,co', 'los angeles, ca', '12')
        expect(weather).to eq({conditions: "clear sky", temperature: 55.6,})
      end
    end
  end
end
