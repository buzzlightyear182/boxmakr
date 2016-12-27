class Item < ApplicationRecord
  require 'csv'

  validates_uniqueness_of :description
  validates :description, :brand, :category, presence: true
  belongs_to :brand
  belongs_to :category
  has_and_belongs_to_many :boxes, join_table: :box_items

  monetize :case_price_centavos

  def unit_price
    (case_price_centavos/100.to_f)/case_size
  end

  def case_cbm
    unless case_dimension_length.nil?
      (case_dimension_length * case_dimension_width * case_dimension_height).round(4)
    end
  end

  def unit_price_in_peso
    exchange_rate = ExchangeRate.find_by_base_currency(case_price_currency)
    peso_price = exchange_rate.amount * unit_price
    peso_price.round(2)
  end

  def self.upload(file)
    @errors = []
    unless file.nil?
      spreadsheet = Roo::Spreadsheet.open(file.path)
      header = spreadsheet.sheet(0).row(1)
      (2..spreadsheet.sheet(0).last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        item = find_by(id: row["id"]) || new
        item.attributes = row.to_hash
        unless item.save
          item.errors.full_messages.each do |message|
            @errors << "Error on row #{i}: #{message}"
          end
        end
      end
    else
      @errors << "No file loaded"
    end
    return @errors
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      headings = ["id","description","brand_id","category_id","shelf_life","top_SKU","unit_size","case_size","case_price_centavos","case_price_currency","case_weight","case_pallet","case_dimension_length","case_dimension_width","case_dimension_height"]
      csv << headings
      all.each do |item|
        item_array = item.attributes.values_at(*headings)
        item_array[8] = item.case_price_centavos/(100.to_f) # Change case_price to non-Money format
        csv << item_array
      end
    end
  end

end
