class Period < ApplicationRecord

  has_many :boxes
  has_many :box_types, through: :boxes

  def total_forecast
    boxes.pluck(:forecast).inject(0){|sum,x| sum + x }
  end

  def total_actual
    return if boxes.first.actual.nil?
    unless boxes.first.actual.nil?
      boxes.pluck(:actual).inject(0){|sum,x| sum + x }
    else
      "-"
    end
  end

end
