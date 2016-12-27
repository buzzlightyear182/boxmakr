class Box < ApplicationRecord

  belongs_to :period
  belongs_to :box_type

  has_and_belongs_to_many :items, join_table: :box_items

  validates_presence_of :box_type_id

  # scope :find_lazy, -> (id) { where(:id => id) }
  scope :trial, -> { where(box_type_id: 1).first }
  scope :regular, -> { where(box_type_id: 2).first }
  scope :premium, -> { where(box_type_id: 3).first }

  def name
    self.period.month_date.strftime('%b %Y').to_s + " " + self.box_type.name + " box"
  end

  def self.upload(file)
    @errors = []
    unless file.nil?
      spreadsheet = Roo::Spreadsheet.open(file.path)
      header = spreadsheet.sheet(0).row(1)
      (2..spreadsheet.sheet(0).last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]

        period_id = Period.find_by_month_date(row['month_date']).id
        row[:period_id] = period_id

        box = where(period_id: period_id, box_type_id: row['box_type_id']).first || new

        box.attributes = row.except('month_date').to_hash
        unless box.save
          box.errors.full_messages.each do |message|
            @errors << "Error on row #{i}: #{message}"
          end
        end
      end
    else
      @errors << "No file loaded"
    end
    return @errors
  end

  def has_item?(item)
    items.include? item
  end

  def add_item(item)
    items << item
  end
end
