FactoryBot.define do
  factory :bulk_discount do
    discount {Faker::Number.number(digits: 2)}
    threshold {Faker::Number.within(range: 1..1000)}
    merchant
  end
end