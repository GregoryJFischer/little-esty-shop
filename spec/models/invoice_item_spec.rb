require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :invoice}
  end

  describe 'instance methods' do
    before :each do
      @invoice = create(:invoice)

      @merchant = create(:merchant)

      @item = create(:item, merchant: @merchant)

      @discount1 = create(:bulk_discount, merchant: @merchant, threshold: 11, discount: 10)
      @discount2 = create(:bulk_discount, merchant: @merchant, threshold: 11, discount: 5)

      @invoice_item = create(:invoice_item, item: @item, invoice: @invoice, unit_price: 1, quantity: 10)
    end

    describe 'find_discount' do
      it 'finds the discount associated with the invoice item' do
        expect(@invoice_item.find_discount).to eq @discount1
      end
    end
  end
end
