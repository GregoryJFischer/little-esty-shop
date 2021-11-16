class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  delegate :merchant, to: :item
  delegate :customer, to: :invoice

  enum status: { "packaged" => 0,
                 "pending" => 1,
                 "shipped" => 2
               }

  scope :invoice_item_revenue, -> { sum("unit_price * quantity") }

  def self.invoice_item_price(invoice)
    find_by(invoice: invoice).unit_price
  end

  def self.invoice_item_quantity(invoice)
    find_by(invoice: invoice).quantity
  end

  def self.invoice_item_status(invoice)
    find_by(invoice: invoice).status
  end

  def self.discounts
    joins(item: {merchant: :bulk_discounts})
    .select("MAX(bulk_discounts.discount) as discount,
            invoice_items.quantity as quantity,
            invoice_items.unit_price as unit_price")
    .where("quantity > bulk_discounts.threshold")
    .group("invoice_items.id")
  end

  def find_discount
    discounts = item.merchant.bulk_discounts

    valid_discounts = discounts.select do |discount|
      discount.threshold < self.quantity
    end

    valid_discounts.max_by { |discount| discount.discount }
  end
end
