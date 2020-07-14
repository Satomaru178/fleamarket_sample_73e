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

  factory :takashi, class: User do
    nickname              { "takashi" }
    email                 { "takashi@example.com" }
    password              { "password" }
    password_confirmation { "password" }
    first_name            { "新井" }
    last_name             { "隆" }
    first_name_kana       { "あらい" }
    last_name_kana        { "たかし" }
    birthday              { "1995-6-15" }
  end

  factory :satoshi, class: User do
    nickname              { "satoshi" }
    email                 { "satoshi@example.com" }
    password              { "password" }
    password_confirmation { "password" }
    first_name            { "石田" }
    last_name             { "智" }
    first_name_kana       { "いしだ" }
    last_name_kana        { "さとし" }
    birthday              { "1998-8-24" }
  end
end
