class Conversion < ApplicationRecord
  belongs_to :source_currency, class_name: 'Currency', foreign_key: 'source', primary_key: 'code'
  belongs_to :target_currency, class_name: 'Currency', foreign_key: 'target', primary_key: 'code'

  validates :source, :target, :source_amount, :amount, :exchange_rate, :rate_fetched_time, presence: true
  validates :source_amount, :amount, :exchange_rate, numericality: { greater_than: 0 }

  validate :source_and_target_different

  private

  def source_and_target_different
    if source.present? && target.present? && source == target
      errors.add(:source, "cannot be the same as target currency")
    end
  end
end
