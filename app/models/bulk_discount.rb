class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :threshold, presence: true
  validates :discount, presence: true

  def format_discount
    "#{discount}%"
  end

  def percentage
    discount / 100.0
  end
end