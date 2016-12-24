class Brand < ApplicationRecord
  require 'csv'

  validates :name, :country, presence: true
  belongs_to :company
  has_many :items

  def country_name
    country = ISO3166::Country[self.country]
    country.name
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |brand|
        csv << brand.attributes.values
      end
    end
  end

end
