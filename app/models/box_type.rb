class BoxType < ApplicationRecord

  validates :name, presence: true
  monetize :base_price_centavos
  monetize :threshold_centavos
  has_many :boxes

  def quarter_price
    Money.new(base_price_centavos * 0.92)
  end

  def biannual_price
    Money.new(base_price_centavos * 0.88)
  end

  def annual_price
    Money.new(base_price_centavos * 0.80)
  end

  def target_cost
    Money.new((base_price_centavos * 0.43))
  end

end
