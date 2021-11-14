class BulkDiscountsFacade
  attr_reader :merchant, :bulk_discounts

  def initialize(merchant)
    @merchant = merchant
    @bulk_discounts = merchant.bulk_discounts
  end

  def service
    HolidayService.new
  end

  def names
    service.holiday_names
  end

  def dates
    service.holiday_dates
  end
end