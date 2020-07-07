FactoryBot.define do
  factory :product do
    name               { "test" }
    explain            { "test" }
    condition_id       { 1 }
    costburden_id      { 1 }
    shippingorigin_id  { 1 }
    shippingperiod_id  { 1 }
    price              { 500 }
  end
end
