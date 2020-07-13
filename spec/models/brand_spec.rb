require 'rails_helper'

RSpec.describe Brand, type: :model do
  describe '#create' do
    it "nameがない時は登録できないこと" do
      brand = build(:brand, name: nil)
      expect(brand).to be_invalid
      expect(brand.errors[:name]).to be_present
    end

    it "nameが41文字の時は登録できないこと" do
      brand = build(:brand, name: "a" * 41)
      expect(brand).to be_invalid
      expect(brand.errors[:name]).to be_present
    end

    it "nameが40文字の時は登録できること" do
      brand = build(:brand, name: "a" * 40)
      expect(brand).to be_valid
    end
  end
end
