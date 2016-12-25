class Box < ApplicationRecord

  belongs_to :box_type

  # scope :find_lazy, -> (id) { where(:id => id) }
  scope :for_trial, -> { where(box_type_id: 1) }
  scope :for_regular, -> { where(box_type_id: 2) }
  scope :for_premium, -> { where(box_type_id: 3) }
  scope :by_month, -> (month_date) { where(month_date: month_date) }

  def name
    self.month_date.strftime('%b %Y').to_s + " - " + self.box_type.name
  end

  def self.existing_months
    pluck(:month_date).uniq!
  end

  def self.total_forecast
    pluck(:forecast).inject(0){|sum,x| sum + x }
  end

  def self.upload(file)
    @errors = []
    unless file.nil?
      spreadsheet = Roo::Spreadsheet.open(file.path)
      header = spreadsheet.sheet(0).row(1)
      (2..spreadsheet.sheet(0).last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        box = find_by(id: row["id"]) || new
        box.attributes = row.to_hash
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
end
