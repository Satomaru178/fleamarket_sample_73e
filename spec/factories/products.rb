FactoryBot.define do
  factory :product do
    id                 { 1 }
    name               { "test" }
    explain            { "test" }
    seller_id          { 1 }
    buyer_id           { 2 }
    category_id        { 1 }
    brand_id           { 1 }
    condition_id       { 1 }
    costburden_id      { 1 }
    shippingorigin_id  { 1 }
    shippingperiod_id  { 1 }
    price              { 500 }
  end
end
