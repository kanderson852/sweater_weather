require 'rails_helper'

RSpec.describe PhotoService, type: :service do
  context 'class methods' do
    describe '::conn' do
      it 'returns Faraday connection', :vcr do
        response = PhotoService.conn

        expect(response).to be_a(Faraday::Connection)
      end
    end

    describe '::find_image', :vcr do
      it 'returns an image url for a given location' do
         photo = PhotoService.find_image('denver, co')

         expect(photo).to be_a(Hash)
       end
     end
  end
end
