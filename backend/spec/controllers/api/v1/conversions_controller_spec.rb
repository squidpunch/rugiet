require 'rails_helper'

RSpec.describe Api::V1::ConversionsController, type: :controller do
  describe 'GET #index' do

    context 'when there are conversions' do
      before(:each) do
        Conversion.create!(
          source: 'USD',
          target: 'EUR',
          source_amount: 100,
          amount: 85,
          exchange_rate: 0.85,
          rate_fetched_time: Time.current
        )
      end

      after(:each) do
        Conversion.destroy_all
      end

      it 'returns the conversions in json format' do
        get :index
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq(1)
        expect(json_response.first).to include(
          'source' => 'USD',
          'target' => 'EUR',
          'source_amount' => '100.0'
        )
      end
    end

    it 'limits results to 50 by default' do
      get :index

      expect(Conversion).to receive(:limit).with(50).and_call_original
      get :index
    end
  end

  describe 'POST #convert' do
    let(:conversion_params) do
      {
        conversion: {
          source_amount: 100,
          source: 'USD',
          target: 'EUR'
        }
      }
    end

    let(:mock_service) { instance_double(ExchangeRateFetcherService) }
    let(:mock_exchange_rate) { instance_double(ExchangeRate, rate: 0.85, updated_at: Time.now) }

    before do
      allow(ExchangeRateFetcherService).to receive(:new).and_return(mock_service)
      allow(mock_service).to receive(:get_exchange_rate).and_return(mock_exchange_rate)
    end

    it 'calls ExchangeRateFetcherService with source and target currencies' do
      post :convert, params: conversion_params

      expect(ExchangeRateFetcherService).to have_received(:new).with('USD', 'EUR')
    end

    it 'calls get_exchange_rate on the service' do
      post :convert, params: conversion_params

      expect(mock_service).to have_received(:get_exchange_rate)
    end

    it 'returns a successful response' do
      post :convert, params: conversion_params

      expect(response).to have_http_status(:success)
    end

    it 'creates a new conversion record' do
      expect { post :convert, params: conversion_params }.to change(Conversion, :count).by(1)
    end

    it 'returns the conversion object as JSON' do
      post :convert, params: conversion_params

      json_response = JSON.parse(response.body)
      expect(json_response).to include(
        'source' => 'USD',
        'target' => 'EUR',
        'source_amount' => '100.0',
        'amount' => '85.0',
        'exchange_rate' => '0.85'
      )
      expect(json_response).to have_key('rate_fetched_time')
    end
  end
end
