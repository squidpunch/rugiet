class ExchangeRate < ApplicationRecord
  belongs_to :base_currency, class_name: 'Currency', foreign_key: 'base', primary_key: 'code'
  belongs_to :target_currency, class_name: 'Currency', foreign_key: 'target', primary_key: 'code'

  validates :base, :target, presence: true
  validates :date, presence: true
  validates :rate, presence: true, numericality: { greater_than: 0 }

  validate :base_and_target_different

  private

  def base_and_target_different
    if base.present? && target.present? && base == target
      errors.add(:base, "cannot be the same as target currency")
    end
  end
end
