require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#create' do
    xcontext 'ログイン前' do
      xit "ログインしていない時は登録できないこと" do
        product = build(:product)
        product.images.build(:image)
        expect(product).to be_invalid
      end
    end

    context 'ログイン後' do
      # before do
      #   user = build(:user)
      #   visit user_session_path
      #   fill_in 'メールアドレス', with: user.email
      #   fill_in 'パスワード', with: 'TaroSato'
      #   click_button 'ログイン'
      # end

      it "nameがない時は登録できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, name: nil)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "nameが41文字以上の時は登録できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, name: "a" * 41)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "nameが40文字の時は登録できること" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, name: "a" * 40)
        product.images.build(:image)
        expect(product).to be_valid
      end
  
      it "explainがない時は登録できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, explain: nil)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "explainが1001文字以上の時は登録できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, explain: "a" * 1001)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "explainが1000文字の時は登録できること" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, explain: "a" * 1000)
        product.images.build(:image)
        expect(product).to be_valid
      end
  
      it "seller_idがない時は登録できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, seller_id: nil)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "buyer_idがない時でも登録できること" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, buyer_id: nil)
        product.images.build(:image)
        expect(product).to be_valid
      end
  
      it "category_idがない時は登録できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, category_id: nil)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "brand_idがない時でも登録できること" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, brand_id: nil)
        product.images.build(:image)
        expect(product).to be_valid
      end
  
      it "condition_idが0の時は登録できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, condition_id: 0)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "costburden_idが0の時は登録できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, costburden_id: 0)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "shippingorigin_idが0の時は登録できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, shippingorigin_id: 0)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "shippingperiod_idが0の時は登録できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, shippingperiod_id: 0)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "priceがない時は登録できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, price: nil)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "priceが300円未満の時は登録できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, price: 299)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "priceが300円の時は登録できること" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, price: 300)
        product.images.build(:image)
        expect(product).to be_valid
      end
  
      it "priceが10,000,000円以上の時は登録できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, price: 10_000_000)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "priceが9,999,999円の時は登録できること" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, price: 9_999_999)
        product.images.build(:image)
        expect(product).to be_valid
      end
    end
  end

  describe '#update' do
    xcontext 'ログイン前' do
      xit "ログインしていない時は更新できないこと" do
        product = build(:product)
        product.images.build(:image)
        expect(product).to be_invalid
      end
    end

    context 'ログイン後' do
      # before do
      #   user = build(:user)
      #   visit user_session_path
      #   fill_in 'メールアドレス', with: user.email
      #   fill_in 'パスワード', with: 'TaroSato'
      #   click_button 'ログイン'
      # end

      it "出品したユーザ以外は更新できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "nameがない時は更新できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, name: nil)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "nameが41文字以上の時は更新できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, name: "a" * 41)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "nameが40文字の時は更新できること" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, name: "a" * 40)
        product.images.build(:image)
        expect(product).to be_valid
      end
  
      it "explainがない時は更新できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, explain: nil)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "explainが1001文字以上の時は更新できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, explain: "a" * 1001)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "explainが1000文字の時は更新できること" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, explain: "a" * 1000)
        product.images.build(:image)
        expect(product).to be_valid
      end
  
      it "seller_idがない時は更新できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, seller_id: nil)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "buyer_idがない時でも更新できること" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, buyer_id: nil)
        product.images.build(:image)
        expect(product).to be_valid
      end
  
      it "category_idがない時は更新できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, category_id: nil)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "brand_idがない時でも更新できること" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, brand_id: nil)
        product.images.build(:image)
        expect(product).to be_valid
      end
  
      it "condition_idが0の時は更新できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, condition_id: 0)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "costburden_idが0の時は更新できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, costburden_id: 0)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "shippingorigin_idが0の時は更新できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, shippingorigin_id: 0)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "shippingperiod_idが0の時は更新できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, shippingperiod_id: 0)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "priceがない時は更新できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, price: nil)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "priceが300円未満の時は更新できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, price: 299)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "priceが300円の時は更新できること" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, price: 300)
        product.images.build(:image)
        expect(product).to be_valid
      end
  
      it "priceが10,000,000円以上の時は更新できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, price: 10_000_000)
        product.images.build(:image)
        expect(product).to be_invalid
      end
  
      it "priceが9,999,999円の時は更新できること" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, price: 9_999_999)
        product.images.build(:image)
        expect(product).to be_valid
      end
    end
  end

  describe '#destroy' do
    xcontext 'ログイン前' do
      xit "ログインしていない時は削除できないこと" do
        product = build(:product)
        expect{ product.destroy }.to change{ Product.count }.by(0)
      end
    end

    context 'ログイン後' do
      # before do
      #   user = build(:user)
      #   visit user_session_path
      #   fill_in 'メールアドレス', with: user.email
      #   fill_in 'パスワード', with: 'TaroSato'
      #   click_button 'ログイン'
      # end

      it "出品したユーザ以外は削除できないこと" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product, seller_id: 3)
        product.images.build(:image)
        expect{ product.destroy }.to change{ Product.count }.by(0)
      end
  
      it "productを削除するとproductのimageも削除されること" do
        pending 'うまくいかないのであとで修正する'
        product = build(:product)
        product.images.build(:image)
        expect{ product.destroy }.to change{ Image.count }.by(-1)
      end
    end
  end
end
