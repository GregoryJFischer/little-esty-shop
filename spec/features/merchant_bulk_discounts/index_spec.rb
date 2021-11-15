require 'rails_helper'

RSpec.describe 'bulk discount index' do
  before :each do
    @merchant = create(:merchant)

    @discount1, @discount2, @discount3 = create_list(:bulk_discount, 3, merchant: @merchant)
  end

  it 'displays the discounts info' do
    visit merchant_bulk_discounts_path(@merchant)

    within("#discount-#{@discount1.id}") do
      expect(page).to have_content(@discount1.threshold)
      expect(page).to have_content(@discount1.discount)
    end
  end

  it 'can delete a discount' do
    visit merchant_bulk_discounts_path(@merchant)

    id = @discount1.id

    within("#discount-#{id}") do
      click_link("Delete")
    end

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
    expect(page).to_not have_css("#discount-#{id}")
  end

  it 'can create a new discount' do
    visit merchant_bulk_discounts_path(@merchant)

    click_link("New Discount")

    expect(current_path).to eq "/merchants/#{@merchant.id}/bulk_discounts/new"

    fill_in "Item Threshold", with: 15
    fill_in 'Discount Percentage', with: 10
    click_button 'Save'

    id = BulkDiscount.last.id

    within("#discount-#{id}") do
      expect(page).to have_content "Discount: 10% Threshold: 15"
    end
  end

  it "doesn't allow creating an invalid discount" do
    visit merchant_bulk_discounts_path(@merchant)

    click_link("New Discount")

    expect(current_path).to eq "/merchants/#{@merchant.id}/bulk_discounts/new"

    fill_in "Item Threshold", with: 15
    fill_in 'Discount Percentage', with: 101
    click_button 'Save'

    expect(page).to have_content "Error - could not create bulk discount"
  end

  it 'lists the next three holidays' do
    visit merchant_bulk_discounts_path(@merchant)

    expect("Thanksgiving").to appear_before("Christmas Day")
    expect("Christmas Day").to appear_before("New Year's Day")
  end
end