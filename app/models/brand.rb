class Brand < ApplicationRecord

  validates :name, :country, presence: true
  belongs_to :company
  has_many :items

  def country_name
    country = ISO3166::Country[self.country]
    country.name
  end

end
