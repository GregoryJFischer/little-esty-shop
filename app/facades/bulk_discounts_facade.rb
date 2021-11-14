class BulkDiscountsFacade
  attr_reader :merchant, :bulk_discounts

  def initialize(merchant)
    @merchant = merchant
    @bulk_discounts = merchant.bulk_discounts
  end
end