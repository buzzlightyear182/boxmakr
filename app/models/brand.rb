class Brand < ApplicationRecord

  validates :name, presence: true
  belongs_to :company

  def country_name
    country = ISO3166::Country[self.country]
    country.name
  end

end
