require 'rails_helper'

RSpec.describe RoadTripFacade, type: :facade do
  context 'class methods' do
    describe '::road_trip', :vcr do
      it 'should return road trip data' do
        trip = RoadTripFacade.road_trip('denver,co', 'pueblo,co')

        expect(trip).to be_a(RoadTrip)
      end
    end
  end
end
