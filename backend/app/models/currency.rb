class Currency < ApplicationRecord
  validates :code, presence: true, uniqueness: true, length: { is: 3 }
  validates :name, presence: true
end
