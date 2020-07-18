require 'rails_helper'

RSpec.describe Category, type: :model do
  it "nameがない時は登録できないこと" do
    category = build(:category, name: nil)
    expect(category).to be_invalid
    expect(category.errors[:name]).to include("を入力してください")
  end

  it "nameが41文字以上の時は登録できないこと" do
    category = build(:category, name: "a" * 41)
    expect(category).to be_invalid
    expect(category.errors[:name]).to include("は40文字以内で入力してください")
  end

  it "nameが40文字の時は登録できること" do
    category = build(:category, name: "a" * 40)
    expect(category).to be_valid
    expect(category.errors[:name]).not_to be_present
  end
end
