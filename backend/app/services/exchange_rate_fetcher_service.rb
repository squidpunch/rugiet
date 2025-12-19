require 'net/http'
require 'json'

class ExchangeRateFetcherService
  # this model will manage the interactions with our data models and the external API refreshing if needed

  def initialize(source, target)
      @source = source
      @target = target
  end

  def get_exchange_rate
    # search for existing exchange rate or create new
    @current_exchange_rate = ExchangeRate.latest_cached_rate(@source, @target)

    if @current_exchange_rate.nil?
      # we dont have a valid cached record so we must create or updtae our cache table
      @current_exchange_rate = ExchangeRate.find_or_create_by(base: @source, target: @target)

      # we need to pull the current data from the API to update this record
      @rate_data = pull_from_frankfurter_api

      @current_exchange_rate.update(rate: @rate_data["rates"][@target], date: @rate_data["date"])

      ## TODO optimization we could do the reverse data record at this time as well....

      @current_exchange_rate
    end
  end

  private

  def pull_from_frankfurter_api
    @url = "https://api.frankfurter.dev/v1/latest?base=#{@source}&symbols=#{@target}"
    response = Net::HTTP.get_response(URI.parse(@url))
    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      # TODO better error handling....
      puts "Failed to fetch data: #{response.message}"
      nil
    end
  end
end