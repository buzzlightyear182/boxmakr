class Period < ApplicationRecord

  has_many :boxes
  has_many :box_types, through: :boxes

  def total_forecast
    boxes.pluck(:forecast).inject(0){|sum,x| sum + x }
  end

end
