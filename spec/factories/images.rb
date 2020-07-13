FactoryBot.define do
  factory :image do
    id         { 1 }
    product_id { 1 }
    src        { "hoge.png" }
  end
end
