module Api
  module V1
    class ConversionsController < ApplicationController

      def index
        limit = params[:limit]&.to_i || 50
        @conversions = Conversion.limit(limit)
        render json: @conversions
      end

    end
  end
end
