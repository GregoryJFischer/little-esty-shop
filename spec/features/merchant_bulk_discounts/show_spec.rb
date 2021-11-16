require 'rails_helper'

RSpec.describe 'bulk discount show' do
  before :each do
    @bulk_discount = create(:bulk_discount, threshold: 1, discount: 15)
  end
  it 'should have the bulk discount information' do
    visit "/merchants/#{@bulk_discount.merchant_id}/bulk_discounts/#{@bulk_discount.id}"

    expect(page).to have_content(@bulk_discount.format_discount)
    expect(page).to have_content(@bulk_discount.threshold)
  end

  it 'should be able to edit the bulk discount' do
    visit "/merchants/#{@bulk_discount.merchant_id}/bulk_discounts/#{@bulk_discount.id}"

    click_link "Edit"

    fill_in "Item Threshold", with: 2
    fill_in "Discount Percentage", with: 25
    click_button "Save"

    expect(current_path).to eq "/merchants/#{@bulk_discount.merchant_id}/bulk_discounts/#{@bulk_discount.id}"

    expect(page).to have_content "Discount: 25%"
    expect(page).to have_content "Threshold: 2"
  end
end
