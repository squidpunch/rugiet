module Api
  module V1
    class CurrenciesController < ApplicationController
      def index
        @currencies = Currency.all.order(:code)
        render json: @currencies
      end
    end
  end
end
