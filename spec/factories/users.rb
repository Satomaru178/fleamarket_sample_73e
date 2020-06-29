FactoryBot.define do
  
  factory :user do
    nickname              {"taro"}
    email                 {"taro@gmail.com"}
    password              {"TaroSato"}
    password_confirmation {"TaroSato"}
    family_name            {"佐藤"}
    first_name             {"太郎"}
    family_name_kana       {"さとう"}
    first_name_kana        {"たろう"}
    birthday              {"1990-1-1"}
  end
end