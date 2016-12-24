class Item < ApplicationRecord
  require 'csv'

  validates_uniqueness_of :description
  validates :description, :brand, :category, presence: true
  belongs_to :brand
  belongs_to :category

  monetize :case_price_centavos

  def unit_price
    (case_price_centavos/100.to_f)/case_size
  end

  def case_cbm
    unless case_dimension_length.nil?
      (case_dimension_length * case_dimension_width * case_dimension_height).round(4)
    end
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

end