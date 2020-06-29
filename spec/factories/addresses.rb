FactoryBot.define do
  
  factory :address do
    family_name       {"佐藤"}
    first_name        {"太郎"}
    family_name_kana  {"さとう"}
    first_name_kana   {"たろう"}
    zipcode          {"1234567"}
    prefecture       {"北海道"}
    city    {"札幌市"}
    address          {"北区北６条西４丁目"}
    address_other    {""}
    tell             {"08011112222"}
  end
end