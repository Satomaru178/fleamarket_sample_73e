FactoryBot.define do
  factory :category do
    id       { 1 }
    name     { "test" }
    ancestry { "1/2" }
  end
end
