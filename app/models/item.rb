class Item < ApplicationRecord

  validates :description, :brand, presence: true
  belongs_to :brand
  belongs_to :category

  monetize :case_price_centavos

  def unit_price
    (case_price_centavos/100)/case_size.round(2)
  end

  def case_cbm
    unless case_dimension_length.nil?
      case_dimension_length * case_dimension_width * case_dimension_height
    end
  end

end
