require 'rails_helper'

RSpec.describe Api::V1::ConversionsController, type: :controller do
  describe 'GET #index' do
    let!(:usd) { Currency.create!(code: 'USD', name: 'United States Dollar') }
    let!(:eur) { Currency.create!(code: 'EUR', name: 'Euro') }
    let!(:conversion1) do
      Conversion.create!(
        source: 'USD',
        target: 'EUR',
        source_amount: 100,
        amount: 85,
        exchange_rate: 0.85,
        rate_fetched_time: Time.current
      )
    end
    let!(:conversion2) do
      Conversion.create!(
        source: 'EUR',
        target: 'USD',
        source_amount: 100,
        amount: 117.65,
        exchange_rate: 1.1765,
        rate_fetched_time: Time.current
      )
    end

    it 'returns all conversions' do
      get :index

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(2)
    end

    it 'returns conversions as JSON' do
      get :index

      json_response = JSON.parse(response.body)
      expect(json_response.first).to include(
        'source' => 'USD',
        'target' => 'EUR',
        'source_amount' => '100.0'
      )
    end

    it 'limits results to 50 by default' do
      get :index

      expect(Conversion).to receive(:limit).with(50).and_call_original
      get :index
    end

    it 'respects custom limit parameter' do
      get :index, params: { limit: 1 }

      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(1)
    end
  end

end
