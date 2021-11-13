require 'rails_helper'

RSpec.describe 'bulk discount index' do
  before :each do
    @merchant = create(:merchant)

    @discount1, @discount2, @discount3 = create_list(:bulk_discount, 3, merchant: @merchant)
  end

  xit 'displays the discounts info' do
    visit merchants_bulk_discounts_path(@merchant)

    within("#discount-#{@discount1.id}") do
      expect(page).to have_content(@discount1.threshold)
      expect(page).to have_content(@discount1.discount)
    end
  end
end