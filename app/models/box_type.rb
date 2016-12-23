class BoxType < ApplicationRecord

  validates :name, presence: true
  monetize :price_centavos

end
