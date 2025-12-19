require 'rails_helper'

RSpec.describe ExchangeRateFetcherService do
    before do
        ExchangeRate.destroy_all
    end

    describe "#get_exchange_rate" do
        context "when there is no exchange rate object" do
            it "should have persisted a exchange rate record" do
                service = ExchangeRateFetcherService.new("USD", "EUR")
                service.get_exchange_rate
                expect(ExchangeRate.count).to eq(1)
            end
        end

        context "when there is a valid cached exchange rate object" do
            before do
                ExchangeRate.create(base: "USD", target: "EUR", rate: 0.85, created_at: Time.now)
            end
            after do
                ExchangeRate.destroy_all
            end

            it "should not have persisted a new exchange rate record" do
                service = ExchangeRateFetcherService.new("USD", "EUR")
                service.get_exchange_rate
                expect(ExchangeRate.count).to eq(1)
            end

        end

        context "when there is a expired exchange rate object" do
            before do
                ExchangeRate.create(base: "USD", target: "EUR", rate: 0.85, created_at: Time.now, updated_at: Time.now - 20.minutes)
            end

            after do
                ExchangeRate.destroy_all
            end

            it "should have updated the exchange rate record" do
                service = ExchangeRateFetcherService.new("USD", "EUR")
                service.get_exchange_rate
                expect(ExchangeRate.count).to eq(1)
                expect(ExchangeRate.first.updated_at).to be > Time.now - 10.minutes
            end
        end
    end

end