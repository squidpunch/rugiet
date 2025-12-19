class ExchangeRate < ApplicationRecord
  belongs_to :base_currency, class_name: 'Currency', foreign_key: 'base', primary_key: 'code'
  belongs_to :target_currency, class_name: 'Currency', foreign_key: 'target', primary_key: 'code'

  validates :base, :target, presence: true
  validates :date, presence: true
  validates :rate, presence: true, numericality: { greater_than: 0 }
  validates :base, uniqueness: { scope: [:target, :date], message: "exchange rate already exists for this currency pair on this date" }

  validate :base_and_target_different

  # Scope to find cached rates for a currency pair (updated within last hour)
  scope :cached_for_pair, ->(base, target) {
    where(base: base, target: target)
      .where('updated_at >= ?', 1.hour.ago)
      .order(updated_at: :desc)
  }

  # Get the latest cached rate for a currency pair
  def self.latest_cached_rate(base, target)
    cached_for_pair(base, target).first
  end

  private

  def base_and_target_different
    if base.present? && target.present? && base == target
      errors.add(:base, "cannot be the same as target currency")
    end
  end
end
