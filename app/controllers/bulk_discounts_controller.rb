class BulkDiscountsController < ApplicationController
  def index
    @facade = BulkDiscountsFacade.new(Merchant.find(params[:merchant_id]))
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    bulk_discount = BulkDiscount.new(discount_params)

    if bulk_discount.save
      redirect_to merchant_bulk_discounts_path(Merchant.find(params[:merchant_id]))
    else
      flash[:alert] = "Error - could not create bulk discount"
      redirect_to merchant_bulk_discounts_path(Merchant.find(params[:merchant_id]))
    end
  end

  def edit
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    bulk_discount = BulkDiscount.find(params[:id])

    if bulk_discount.update(discount_params)
      redirect_to merchant_bulk_discounts_path(Merchant.find(params[:merchant_id]))
    else
      flash[:alert] = "Error - could not update bulk discount"
      redirect_to merchant_bulk_discounts_path(Merchant.find(params[:merchant_id]))
    end
  end

  def destroy
    BulkDiscount.find(params[:id]).destroy

    redirect_to merchant_bulk_discounts_path(Merchant.find(params[:merchant_id]))
  end

  private

  def discount_params
    params.permit(:discount, :threshold, :merchant_id)
  end
end