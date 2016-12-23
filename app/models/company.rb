class Company < ApplicationRecord

  validates :name, presence: true
  has_many :brands

  def country_name
    country = ISO3166::Country[self.country]
    country.name
  end

  def self.country_names
    country_codes = Country.pluck(:country)
    country_array = []
    country_codes.each do |ccode|
      country = ISO3166::Country[ccode]
      country_array << country.name
    end
    country_array
  end

end
