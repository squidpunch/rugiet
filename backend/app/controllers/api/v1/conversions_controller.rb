module Api
  module V1
    class ConversionsController < ApplicationController
      def index
        limit = params[:limit]&.to_i || 50
        @conversions = Conversion.limit(limit)
        render json: @conversions
      end

      def convert
        @conversion = Conversion.new(conversion_params)
        @amount = @conversion.source_amount
        @source = @conversion.source
        @target = @conversion.target

        @exchange_rate = ExchangeRateFetcherService.new(@source, @target).get_exchange_rate
        @converted_amount = @amount * @exchange_rate.rate

        @conversion.update(
          amount: @converted_amount,
          exchange_rate: @exchange_rate.rate,
          rate_fetched_time: @exchange_rate.updated_at
        )

        render  json: @conversion
      end

      private

      def conversion_params
        params.require(:conversion).permit(:source_amount, :source, :target)
      end

    end
  end
end
