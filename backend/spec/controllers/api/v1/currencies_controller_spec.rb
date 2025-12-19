require 'rails_helper'

RSpec.describe Api::V1::CurrenciesController, type: :controller do
  describe 'GET #index' do
    let!(:usd) { Currency.create!(code: 'USD', name: 'United States Dollar') }
    let!(:eur) { Currency.create!(code: 'EUR', name: 'Euro') }
    let!(:gbp) { Currency.create!(code: 'GBP', name: 'British Pound') }

    it 'returns all currencies' do
      get :index

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(3)
    end

    it 'returns currencies as JSON with code and name' do
      get :index

      json_response = JSON.parse(response.body)
      expect(json_response.first).to include(
        'code' => 'EUR',
        'name' => 'Euro'
      )
    end

    it 'returns currencies ordered by code' do
      get :index

      json_response = JSON.parse(response.body)
      codes = json_response.map { |c| c['code'] }
      expect(codes).to eq(['EUR', 'GBP', 'USD'])
    end
  end
end
