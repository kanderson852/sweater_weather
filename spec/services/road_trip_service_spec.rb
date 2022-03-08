require 'rails_helper'

RSpec.describe RoadTripService, type: :service do
  context 'class methods' do
    describe '::conn' do
      it 'returns Faraday connection', :vcr do
        response = RoadTripService.conn

        expect(response).to be_a(Faraday::Connection)
      end
    end

    describe '::get_directions' do
      it 'returns trip information given an origin and destination', :vcr do
         trip = RoadTripService.get_directions("Denver, CO", "Lincoln, Nebraska")

         expect(trip).to be_a(Hash)
         expect(trip).to have_key(:route)
      end

      it 'returns time as impossible given an origin and destination that dont connect', :vcr do
        trip = RoadTripService.get_directions("Denver, CO", "London, UK")
        expect(trip).to be_a(Hash)
        expect(trip[:info][:messages][0]).to eq("We are unable to route with the given locations.")
      end
    end

    describe '::formatted_data' do
      it 'returns trip information and pulls out the needed info', :vcr do
         trip = RoadTripService.formatted_data("Denver, CO", "Lincoln, Nebraska")

         expect(trip).to be_a(Hash)
         expect(trip).to eq(  {
             travel_time: "10:47:46",
             origin: "Denver, CO",
             destination: "Lincoln, Nebraska",
             location: {:lng=>-96.70261, :lat=>40.813599}
           })
      end

      it 'returns trip information for an invalid destination', :vcr do
         trip = RoadTripService.formatted_data("Denver, CO", "London, UK")

         expect(trip).to be_a(Hash)
         expect(trip).to eq(  {
           travel_time: 'impossible',
           origin: "Denver, CO",
           destination: "London, UK",
           location: ''
         })
      end
    end
  end
end
