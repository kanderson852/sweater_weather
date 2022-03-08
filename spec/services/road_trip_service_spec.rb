require 'rails_helper'

RSpec.describe RoadTripService, type: :service do
  context 'class methods' do
    describe '::conn' do
      it 'returns Faraday connection', :vcr do
        response = RoadTripService.conn

        expect(response).to be_a(Faraday::Connection)
      end
    end

    describe '::get_lat_long' do
      it 'returns trip information given an origin and destination', :vcr do
         trip = RoadTripService.get_directions("Denver, CO", "Lincoln, Nebraska")

         expect(trip).to be_a(Hash)
         expect(trip).to have_key(:route)
         require "pry"; binding.pry
       end
     end
  end
end
