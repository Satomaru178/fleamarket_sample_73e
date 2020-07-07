require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#create' do
    it "nameがない時は登録できないこと" do
      product = build(:product, name: nil)
      expect(product).to be_invalid
    end

    it "nameが41文字以上の時は登録できないこと" do
      product = build(:product, name: "a" * 41)
      expect(product).to be_invalid
    end

    it "nameが40文字の時は登録できること" do
      product = build(:product, name: "a" * 40)
      expect(product).to be_valid
    end

    it "explainがない時は登録できないこと" do
      product = build(:product, explain: nil)
      expect(product).to be_invalid
    end

    it "explainが1001文字以上の時は登録できないこと" do
      product = build(:product, explain: "a" * 1001)
      expect(product).to be_invalid
    end

    it "explainが1000文字の時は登録できること" do
      product = build(:product, explain: "a" * 1000)
      expect(product).to be_valid
    end

    it "condition_idが0の時は登録できないこと" do
      product = build(:product, condition_id: 0)
      expect(product).to be_invalid
    end

    it "costburden_idが0の時は登録できないこと" do
      product = build(:product, costburden_id: 0)
      expect(product).to be_invalid
    end

    it "shippingorigin_idが0の時は登録できないこと" do
      product = build(:product, shippingorigin_id: 0)
      expect(product).to be_invalid
    end

    it "shippingperiod_idが0の時は登録できないこと" do
      product = build(:product, shippingperiod_id: 0)
      expect(product).to be_invalid
    end

    it "priceがない時は登録できないこと" do
      product = build(:product, price: nil)
      expect(product).to be_invalid
    end

    it "priceが300円未満の時は登録できないこと" do
      product = build(:product, price: 299)
      expect(product).to be_invalid
    end

    it "priceが300円の時は登録できること" do
      product = build(:product, price: 300)
      expect(product).to be_valid
    end

    it "priceが10,000,000円以上の時は登録できないこと" do
      product = build(:product, price: 10_000_000)
      expect(product).to be_invalid
    end

    it "priceが9,999,999円の時は登録できること" do
      product = build(:product, price: 9_999_999)
      expect(product).to be_valid
    end
  end

  describe '#update' do
    it "出品したユーザ以外は更新できないこと" do
      pending 'あとで記載する'
      product = build(:product)
      expect(product).to be_invalid
    end

    it "nameがない時は更新できないこと" do
      product = build(:product, name: nil)
      expect(product).to be_invalid
    end

    it "nameが41文字以上の時は更新できないこと" do
      product = build(:product, name: "a" * 41)
      expect(product).to be_invalid
    end

    it "nameが40文字の時は更新できること" do
      product = build(:product, name: "a" * 40)
      expect(product).to be_valid
    end

    it "explainがない時は更新できないこと" do
      product = build(:product, explain: nil)
      expect(product).to be_invalid
    end

    it "explainが1001文字以上の時は更新できないこと" do
      product = build(:product, explain: "a" * 1001)
      expect(product).to be_invalid
    end

    it "explainが1000文字の時は更新できること" do
      product = build(:product, explain: "a" * 1000)
      expect(product).to be_valid
    end

    it "condition_idが0の時は更新できないこと" do
      product = build(:product, condition_id: 0)
      expect(product).to be_invalid
    end

    it "costburden_idが0の時は更新できないこと" do
      product = build(:product, costburden_id: 0)
      expect(product).to be_invalid
    end

    it "shippingorigin_idが0の時は更新できないこと" do
      product = build(:product, shippingorigin_id: 0)
      expect(product).to be_invalid
    end

    it "shippingperiod_idが0の時は更新できないこと" do
      product = build(:product, shippingperiod_id: 0)
      expect(product).to be_invalid
    end

    it "priceがない時は更新できないこと" do
      product = build(:product, price: nil)
      expect(product).to be_invalid
    end

    it "priceが300円未満の時は更新できないこと" do
      product = build(:product, price: 299)
      expect(product).to be_invalid
    end

    it "priceが300円の時は更新できること" do
      product = build(:product, price: 300)
      expect(product).to be_valid
    end

    it "priceが10,000,000円以上の時は更新できないこと" do
      product = build(:product, price: 10_000_000)
      expect(product).to be_invalid
    end

    it "priceが9,999,999円の時は更新できること" do
      product = build(:product, price: 9_999_999)
      expect(product).to be_valid
    end
  end

  describe '#destroy' do
    it "出品したユーザ以外は削除できないこと" do
      pending 'あとで記載する'
      product = build(:product)
      expect{ product.destroy }.to change{ Product.count }.by(0)
    end

    it "productを削除するとproductのimageも削除されること" do
      pending 'あとで記載する'
      product = build(:product)
      product.images.new(product_id: 1, src: "hoge.png")
      expect{ product.destroy }.to change{ Image.count }.by(-1)
    end
  end
end
