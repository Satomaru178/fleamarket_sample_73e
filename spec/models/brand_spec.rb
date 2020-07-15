require 'rails_helper'

RSpec.describe Brand, type: :model do
  describe '#create' do
    it "nameがない時は登録できないこと" do
      brand = build(:brand, name: nil)
      expect(brand).to be_invalid
      expect(brand.errors[:name]).to include ("を入力してください")
    end

    it "nameが41文字の時は登録できないこと" do
      brand = build(:brand, name: "a" * 41)
      expect(brand).to be_invalid
      expect(brand.errors[:name]).to include ("は40文字以内で入力してください")
    end

    it "nameが40文字の時は登録できること" do
      brand = build(:brand, name: "a" * 40)
      expect(brand).to be_valid
      expect(brand.errors[:name]).not_to be_present
    end
  end
end
