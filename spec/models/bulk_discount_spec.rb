require 'rails_helper'

RSpec.describe BulkDiscount do
  describe 'relationships' do
    it {should belong_to :merchant}
  end

  describe 'validations' do
    it {should validate_presence_of(:threshold)}
    it {should validate_presence_of(:discount)}
  end

  describe 'instance methods' do
    before(:each) do
      @discount = create(:bulk_discount, threshold: 10, discount: 15)
    end

    describe '#format_discount' do
      it 'formats the discount to look like a percentage' do
        expect(@discount.format_discount).to eq "15%"
      end
    end

    describe '#percentage' do
      it 'changes the discount to a float' do
        expect(@discount.percentage).to eq 0.15
      end
    end
  end
end