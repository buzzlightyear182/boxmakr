class BoxType < ApplicationRecord

  validates :name, presence: true
  monetize :base_price_centavos
  monetize :threshold_centavos

  def quarter_price
    (base_price_centavos/100 * 0.92).round
  end

  def biannual_price
    (base_price_centavos/100 * 0.88).round
  end

  def annual_price
    (base_price_centavos/100 * 0.80).round
  end

  def target_cost
    (base_price_centavos/100 * 0.43).round
  end

end
