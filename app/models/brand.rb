class Brand < ApplicationRecord

  validates :name, presence: true
  belongs_to :company

end
