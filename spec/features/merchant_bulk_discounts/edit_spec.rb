require 'rails_helper'

RSpec.describe 'bulk discount edit' do
  it 'should reject invalid information' do
    bulk_discount = create(:bulk_discount, threshold: 1, discount: 15)

    visit "/merchants/#{bulk_discount.merchant_id}/bulk_discounts/#{bulk_discount.id}/edit"

    fill_in "Discount Percentage", with: 101
    click_button 'Save'

    expect(page).to have_content("Error - could not update bulk discount")
  end
end