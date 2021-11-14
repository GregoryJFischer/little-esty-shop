require 'rails_helper'

RSpec.describe 'bulk discount show' do
  before :each do
    @bulk_discount = create(:bulk_discount)
  end
  it 'should have the bulk discount information' do
    visit "/merchants/#{@bulk_discount.merchant_id}/bulk_discounts/#{@bulk_discount.id}"

    expect(page).to have_content(@bulk_discount.format_discount)
    expect(page).to have_content(@bulk_discount.threshold)
  end
end