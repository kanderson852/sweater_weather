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
      end
    end
  end
end
