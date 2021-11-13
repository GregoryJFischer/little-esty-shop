class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :threshold, presence: true
  validates :discount, presence: true
end