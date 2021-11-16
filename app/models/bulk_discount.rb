class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates :discount, presence: true
  validates :discount, numericality: { only_integer: true }
  validates :discount, :inclusion => 1..100

  validates :threshold, presence: true
  validates :threshold, numericality: { only_integer: true }

  def format_discount
    "#{discount}%"
  end

  def percentage
    discount / 100.0
  end
end