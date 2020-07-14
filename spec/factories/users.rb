FactoryBot.define do
  
  factory :user do
    nickname              { "taro" }
    email                 { "taro@gmail.com" }
    password              { "TaroSato" }
    password_confirmation { "TaroSato" }
    first_name            { "佐藤" }
    last_name             { "太郎" }
    first_name_kana       { "さとう" }
    last_name_kana        { "たろう" }
    birthday              { "1990-1-1" }
  end
end
