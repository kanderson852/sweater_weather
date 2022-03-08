require 'rails_helper'

RSpec.describe RoadTrip do
  before do
    @weather = {
      temperature: 73,
      conditions: 'partly cloudy'
    }

    @attributes = {
      start_city: 'Denver',
      end_city: 'Pueblo',
      travel_time: 3550,
      weather_at_eta: @weather
    }
  end

  describe 'class' do
    it 'should return a roadtrip object with the correct attributes' do
      @trip = RoadTrip.new(@attributes)

      expect(@trip.start_city).to eq('Denver')
      expect(@trip.end_city).to eq('Pueblo')
      expect(@trip.travel_time).to eq(3550)
      expect(@trip.weather_at_eta).to eq({:conditions=>"partly cloudy", :temperature=>73})
    end
  end
end
