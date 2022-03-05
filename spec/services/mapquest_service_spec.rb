require 'rails_helper'

RSpec.describe MapquestService, type: :service do
  context 'class methods' do
    describe '::conn' do
      it 'returns Faraday connection', :vcr do
        response = MapquestService.conn

        expect(response).to be_a(Faraday::Connection)
      end
    end

    describe '::get_lat_long' do
      it 'returns a lattitude and longitude', :vcr do
         lat_long = MapquestService.get_lat_long("Denver, CO")

         expect(lat_long).to be_a(Hash)
         expect(lat_long).to have_key(:lat)
         expect(lat_long[:lat]).to eq(39.738453)
       end
     end
  end
end
