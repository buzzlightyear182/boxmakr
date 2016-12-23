class ExchangeRate < ApplicationRecord

  validates :base_currency, presence: true
  monetize :amount_centavos

end
