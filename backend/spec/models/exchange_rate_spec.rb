require 'rails_helper'

RSpec.describe ExchangeRate, type: :model do
  let(:eur) { Currency.find_or_create_by!(code: 'EUR') { |c| c.name = 'Euro' } }
  let(:usd) { Currency.find_or_create_by!(code: 'USD') { |c| c.name = 'US Dollar' } }

  describe 'validations' do

    context 'presence of attributes' do
      it { should validate_presence_of(:base) }
      it { should validate_presence_of(:target) }
      it { should validate_presence_of(:date) }
      it { should validate_presence_of(:rate) }
    end

    it { should validate_numericality_of(:rate).is_greater_than(0) }

    context 'Exchanges are using supported currencies' do
      it 'is invalid with a base currency code that does not exist' do
        exchange_rate = ExchangeRate.new(
          base: 'XXX',
          target: eur.code,
          date: Date.today,
          rate: 0.85
        )
        expect(exchange_rate).not_to be_valid
        expect(exchange_rate.errors[:base_currency]).to include('must exist')
      end

      it 'is invalid with a target currency code that does not exist' do
        exchange_rate = ExchangeRate.new(
          base: eur.code,
          target: 'XXX',
          date: Date.today,
          rate: 0.85
        )
        expect(exchange_rate).not_to be_valid
        expect(exchange_rate.errors[:target_currency]).to include('must exist')
        end
    end

    it 'is invalid if the source and target are the same' do
      exchange_rate = ExchangeRate.new(
          base: eur.code,
          target: eur.code,
          date: Date.today,
          rate: 0.85
        )
      expect(exchange_rate).not_to be_valid
    end
  end

  describe 'creating records' do
    after(:each) do
      ExchangeRate.destroy_all
    end

    it 'successfully creates a valid exchange rate' do
      expect {
        ExchangeRate.create!(
          base: usd.code,
          target: eur.code,
          date: Date.today,
          rate: 0.85
        )
      }.to change(ExchangeRate, :count).by(1)
    end

    it 'stores the rate with correct precision' do
      rate = ExchangeRate.create!(
        base: usd.code,
        target: eur.code,
        date: Date.today,
        rate: 0.923456
      )
      expect(rate.rate).to eq(0.923456)
    end
  end
end
