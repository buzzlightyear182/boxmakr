class Company < ApplicationRecord

  validates :name, :country, presence: true
  has_many :brands
  has_many :products, through: :brands

  def country_name
    country = ISO3166::Country[self.country]
    country.name
  end

end
