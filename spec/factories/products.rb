FactoryBot.define do
  factory :product do
    name               { "test" }
    explain            { "test" }
    condition_id       { 1 }
    costburden_id      { 1 }
    shippingorigin_id  { 1 }
    shippingperiod_id  { 1 }
    price              { 500 }
    seller             { build(:takashi) }
    buyer              { build(:satoshi) }
    category
    brand
  end

  factory :redshirt, class: Product do
    name               { "redshirt" }
    explain            { "test" }
    condition_id       { 2 }
    costburden_id      { 2 }
    shippingorigin_id  { 2 }
    shippingperiod_id  { 2 }
    price              { 2500 }
    seller             { build(:takashi) }
    buyer              { build(:satoshi) }
    category
    brand
  end

  factory :blueshirt, class: Product do
    name               { "blueshirt" }
    explain            { "test" }
    condition_id       { 3 }
    costburden_id      { 3 }
    shippingorigin_id  { 3 }
    shippingperiod_id  { 3 }
    price              { 1500 }
    seller             { build(:satoshi) }
    buyer              { build(:takashi) }
    category
    brand
  end
end
