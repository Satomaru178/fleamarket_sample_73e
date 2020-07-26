require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#create' do
    context 'ログイン前' do
      it "ログインしていない時は登録できないこと" do
        # コントローラーのテストで行う(発展課題)
      end
    end

    context 'ログイン後' do
      it "imageがない時は登録できないこと" do
        product = build(:product)
        expect(product).to be_invalid
      end

      it "nameがない時は登録できないこと" do
        product = build(:product, name: nil)
        product.images.build(src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:name]).to include("を入力してください")
      end
  
      it "nameが41文字以上の時は登録できないこと" do
        product = build(:product, name: "a" * 41)
        product.images.build(src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:name]).to include("は40文字以内で入力してください")
      end
  
      it "nameが40文字の時は登録できること" do
        product = build(:product, name: "a" * 40)
        product.images.build(src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:name]).not_to be_present
      end
  
      it "explainがない時は登録できないこと" do
        product = build(:product, explain: nil)
        product.images.build(src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:explain]).to include("を入力してください")
      end
  
      it "explainが1001文字以上の時は登録できないこと" do
        product = build(:product, explain: "a" * 1001)
        product.images.build(src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:explain]).to include("は1000文字以内で入力してください")
      end
  
      it "explainが1000文字の時は登録できること" do
        product = build(:product, explain: "a" * 1000)
        product.images.build(src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:explain]).not_to be_present
      end
  
      it "sellerがない時は登録できないこと" do
        product = build(:product, seller: nil)
        product.images.build(src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:seller]).to include("を入力してください")
      end
  
      it "buyerがない時でも登録できること" do
        product = build(:product, buyer: nil)
        product.images.build(src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:buyer]).not_to be_present
      end
  
      it "categoryがない時は登録できないこと" do
        product = build(:product, category: nil)
        product.images.build(src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:category]).to include("を入力してください")
      end
  
      it "brandがない時でも登録できること" do
        product = build(:product, brand: nil)
        product.images.build(src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:brand]).not_to be_present
      end
  
      it "condition_idがない時は登録できないこと" do
        product = build(:product, condition_id: nil)
        product.images.build(src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:condition_id]).to include("を入力してください")
      end
  
      it "costburden_idがない時は登録できないこと" do
        product = build(:product, costburden_id: nil)
        product.images.build(src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:costburden_id]).to include("を入力してください")
      end
  
      it "shippingorigin_idがない時は登録できないこと" do
        product = build(:product, shippingorigin_id: nil)
        product.images.build(src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:shippingorigin_id]).to include("を入力してください")
      end
  
      it "shippingperiod_idがない時は登録できないこと" do
        product = build(:product, shippingperiod_id: nil)
        product.images.build(src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:shippingperiod_id]).to include("を入力してください")
      end
  
      it "priceがない時は登録できないこと" do
        product = build(:product, price: nil)
        product.images.build(src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:price]).to include("を入力してください")
      end
  
      it "priceが300円未満の時は登録できないこと" do
        product = build(:product, price: 299)
        product.images.build(src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:price]).to include("は300以上の値にしてください")
      end
  
      it "priceが300円の時は登録できること" do
        product = build(:product, price: 300)
        product.images.build(src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:price]).not_to be_present
      end
  
      it "priceが10,000,000円以上の時は登録できないこと" do
        product = build(:product, price: 10_000_000)
        product.images.build(src: "hoge.png")
        expect(product).to be_invalid
        expect(product.errors[:price]).to include("は10000000より小さい値にしてください")
      end
  
      it "priceが9,999,999円の時は登録できること" do
        product = build(:product, price: 9_999_999)
        product.images.build(src: "hoge.png")
        expect(product).to be_valid
        expect(product.errors[:price]).not_to be_present
      end
    end
  end

  describe '#update' do
    context 'ログイン前' do
      it "ログインしていない時は更新できないこと" do
        # コントローラーのテストで行う(発展課題)
      end
    end

    context 'ログイン後' do
      let!(:product) { create(:product) }

      it "nameがない時は更新できないこと" do
        product = Product.first
        product.update(name: nil)
        expect(product).to be_invalid
        expect(product.errors[:name]).to include("を入力してください")
      end
  
      it "nameが41文字以上の時は更新できないこと" do
        product = Product.first
        product.update(name: "a" * 41)
        expect(product).to be_invalid
        expect(product.errors[:name]).to include("は40文字以内で入力してください")
      end
  
      it "nameが40文字の時は更新できること" do
        product = Product.first
        product.update(name: "a" * 40)
        expect(product).to be_valid
        expect(product.errors[:name]).not_to be_present
      end
  
      it "explainがない時は更新できないこと" do
        product = Product.first
        product.update(explain: nil)
        expect(product).to be_invalid
        expect(product.errors[:explain]).to include("を入力してください")
      end
  
      it "explainが1001文字以上の時は更新できないこと" do
        product = Product.first
        product.update(explain: "a" * 1001)
        expect(product).to be_invalid
        expect(product.errors[:explain]).to include("は1000文字以内で入力してください")
      end
  
      it "explainが1000文字の時は更新できること" do
        product = Product.first
        product.update(explain: "a" * 1000)
        expect(product).to be_valid
        expect(product.errors[:explain]).not_to be_present
      end
  
      it "sellerがない時は更新できないこと" do
        product = Product.first
        product.update(seller: nil)
        expect(product).to be_invalid
        expect(product.errors[:seller]).to include("を入力してください")
      end
  
      it "buyerがない時でも更新できること" do
        product = Product.first
        product.update(buyer: nil)
        expect(product).to be_valid
        expect(product.errors[:buyer]).not_to be_present
      end
  
      it "categoryがない時は更新できないこと" do
        product = Product.first
        product.update(category: nil)
        expect(product).to be_invalid
        expect(product.errors[:category]).to include("を入力してください")
      end
  
      it "brandがない時でも更新できること" do
        product = Product.first
        product.update(brand: nil)
        expect(product).to be_valid
        expect(product.errors[:brand]).not_to be_present
      end
  
      it "condition_idがない時は更新できないこと" do
        product = Product.first
        product.update(condition_id: nil)
        expect(product).to be_invalid
        expect(product.errors[:condition_id]).to include("を入力してください")
      end
  
      it "costburden_idがない時は更新できないこと" do
        product = Product.first
        product.update(costburden_id: nil)
        expect(product).to be_invalid
        expect(product.errors[:costburden_id]).to include("を入力してください")
      end
  
      it "shippingorigin_idがない時は更新できないこと" do
        product = Product.first
        product.update(shippingorigin_id: nil)
        expect(product).to be_invalid
        expect(product.errors[:shippingorigin_id]).to include("を入力してください")
      end
  
      it "shippingperiod_idがない時は更新できないこと" do
        product = Product.first
        product.update(shippingperiod_id: nil)
        expect(product).to be_invalid
        expect(product.errors[:shippingperiod_id]).to include("を入力してください")
      end
  
      it "priceがない時は更新できないこと" do
        product = Product.first
        product.update(price: nil)
        expect(product).to be_invalid
        expect(product.errors[:price]).to include("を入力してください")
      end
  
      it "priceが300円未満の時は更新できないこと" do
        product = Product.first
        product.update(price: 299)
        expect(product).to be_invalid
        expect(product.errors[:price]).to include("は300以上の値にしてください")
      end
  
      it "priceが300円の時は更新できること" do
        product = Product.first
        product.update(price: 300)
        expect(product).to be_valid
        expect(product.errors[:price]).not_to be_present
      end
  
      it "priceが10,000,000円以上の時は更新できないこと" do
        product = Product.first
        product.update(price: 10_000_000)
        expect(product).to be_invalid
        expect(product.errors[:price]).to include("は10000000より小さい値にしてください")
      end
  
      it "priceが9,999,999円の時は更新できること" do
        product = Product.first
        product.update(price: 9_999_999)
        expect(product).to be_valid
        expect(product.errors[:price]).not_to be_present
      end
    end

    context '出品したユーザでない' do
      it "出品したユーザ以外は更新できないこと" do
        # コントローラーのテストで行う(発展課題)
      end
    end
  end

  describe '#destroy' do
    context 'ログイン前' do
      it "ログインしていない時は削除できないこと" do
        # コントローラーのテストで行う(発展課題)
      end
    end

    context 'ログイン後' do
      let!(:product) { create(:product) }

      it "productを削除するとproductのimageも削除されること" do
        expect{ product.destroy }.to change{ Image.count }.by(-1)
      end
    end

    context '出品したユーザでない' do
      it "出品したユーザ以外は削除できないこと" do
        # コントローラーのテストで行う(発展課題)
      end
    end
  end

  describe 'self.serachメソッド' do
    context '引数が入力されている時' do
      it "検索文字列に一致する商品を返す" do
        product = create(:redshirt)
        expect(Product.search("red")).to include(product)
      end

      it "検索結果が1件も見つからなければ空のコレクションを返す" do
        product = create(:blueshirt)
        expect(Product.search("red")).to be_empty
      end
    end

    context '引数が入力されていない時' do
      it "空のコレクションを返す" do
        expect(Product.search("")).to be_empty
      end
    end
  end
end
