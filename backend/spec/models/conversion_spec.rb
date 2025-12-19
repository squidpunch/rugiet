require 'rails_helper'

RSpec.describe Conversion, type: :model do
  let(:usd) { Currency.find_or_create_by(code: 'USD', name: 'United States Dollar') }
  let(:eur) { Currency.find_or_create_by(code: 'EUR', name: 'Euro') }

  describe 'validations' do
    it { should validate_presence_of(:source) }
    it { should validate_presence_of(:target) }
    it { should validate_presence_of(:source_amount) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:exchange_rate) }
    it { should validate_presence_of(:rate_fetched_time) }

    it { should validate_numericality_of(:source_amount).is_greater_than(0) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
    it { should validate_numericality_of(:exchange_rate).is_greater_than(0) }

    it 'validates that source and target are different' do
      conversion = Conversion.new(
        source: 'USD',
        target: 'USD',
        source_amount: 100,
        amount: 100,
        exchange_rate: 1.0,
        rate_fetched_time: Time.current
      )
      expect(conversion).not_to be_valid
      expect(conversion.errors[:source]).to include('cannot be the same as target currency')
    end

    it 'is valid when source and target are different' do
      conversion = Conversion.new(
        source: usd.code,
        target: eur.code,
        source_amount: 100,
        amount: 85,
        exchange_rate: 0.85,
        rate_fetched_time: Time.current
      )
      expect(conversion).to be_valid
    end

    it { should belong_to(:source_currency).class_name('Currency').with_foreign_key('source').with_primary_key('code') }
    it { should belong_to(:target_currency).class_name('Currency').with_foreign_key('target').with_primary_key('code') }
  end
end
