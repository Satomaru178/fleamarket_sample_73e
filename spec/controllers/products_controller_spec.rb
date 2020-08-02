require 'rails_helper'

describe ProductsController do
  describe 'GET #index' do
    let!(:product)  { create(:product) }

    it 'リクエストが成功すること' do
      get :index
      expect(response.status).to eq 200
    end

    it 'indexテンプレートで表示されること' do
      get :index
      expect(response).to render_template :index
    end

    it '@productsが取得できていること' do
      get :index
      expect(assigns(:products)).to include(product)
    end

    context 'キーワード検索' do
      it 'キーワードを含む場合ヒットする' do
        get :index, params: { q: { name_or_explain_cont: 'test' } }
        expect(assigns(:products)).to include(product)
      end

      it 'キーワードを含まない場合ヒットしない' do
        get :index, params: { q: { name_or_explain_cont: 'hoge' } }
        expect(assigns(:products)).not_to include(product)
      end
    end

    context 'カテゴリー検索' do
      it 'カテゴリーが一致する場合ヒットする' do
        get :index, params: { q: { category_id_eq: product.category.id } }
        expect(assigns(:products)).to include(product)
      end

      it 'カテゴリーが一致しない場合ヒットしない' do
        get :index, params: { q: { category_id_eq: product.category.id + 1 } }
        expect(assigns(:products)).not_to include(product)
      end
    end

    context 'ブランド検索' do
      it 'ブランドが一致する場合ヒットする' do
        get :index, params: { q: { brand_id_eq: product.brand.id } }
        expect(assigns(:products)).to include(product)
      end

      it 'ブランドが一致しない場合ヒットしない' do
        get :index, params: { q: { brand_id_eq: product.brand.id + 1 } }
        expect(assigns(:products)).not_to include(product)
      end
    end

    context '商品の状態による検索' do
      it '商品の状態が一致する場合ヒットする' do
        get :index, params: { q: { condition_id_in: 1 } }
        expect(assigns(:products)).to include(product)
      end

      it '商品の状態が一致しない場合ヒットしない' do
        get :index, params: { q: { condition_id_in: 2 } }
        expect(assigns(:products)).not_to include(product)
      end
    end

    context '配送料の負担による検索' do
      it '配送料の負担が一致する場合ヒットする' do
        get :index, params: { q: { costburden_id_in: 1 } }
        expect(assigns(:products)).to include(product)
      end

      it '配送料の負担が一致しない場合ヒットしない' do
        get :index, params: { q: { costburden_id_in: 2 } }
        expect(assigns(:products)).not_to include(product)
      end
    end

    context '発送元の地域による検索' do
      it '発送元の地域が一致する場合ヒットする' do
        get :index, params: { q: { shippingorigin_id_eq: 1 } }
        expect(assigns(:products)).to include(product)
      end

      it '発送元の地域が一致しない場合ヒットしない' do
        get :index, params: { q: { shippingorigin_id_eq: 2 } }
        expect(assigns(:products)).not_to include(product)
      end
    end

    context '発送までの日数による検索' do
      it '発送までの日数が一致する場合ヒットする' do
        get :index, params: { q: { shippingperiod_id_in: 1 } }
        expect(assigns(:products)).to include(product)
      end

      it '発送までの日数が一致しない場合ヒットしない' do
        get :index, params: { q: { shippingperiod_id_in: 2 } }
        expect(assigns(:products)).not_to include(product)
      end
    end

    context '販売価格による検索' do
      it '販売価格が範囲内の場合ヒットする' do
        get :index, params: { q: { price_gteq: 300, price_lteq: 1000 } }
        expect(assigns(:products)).to include(product)
      end

      it '販売価格が範囲外の場合ヒットしない' do
        get :index, params: { q: { price_gteq: 5000, price_lteq: 10000 } }
        expect(assigns(:products)).not_to include(product)
      end
    end
  end

  describe 'GET #new' do
    context 'ログイン前' do
      # 発展課題
    end

    context 'ログイン後' do
      before :each do
        user = create(:user)
        sign_in user
      end

      it 'リクエストが成功すること' do
        get :new
        expect(response.status).to eq 200
      end

      it 'newテンプレートで表示されること' do
        get :new
        expect(response).to render_template :new
      end

      it '@productがnewされていること' do
        get :new
        expect(assigns(:product)).not_to be_nil
      end
    end
  end

  describe 'POST #create' do
    context 'ログイン前' do
      # 発展課題
    end

    context 'ログイン後' do
      before :each do
        user = create(:user)
        sign_in user
      end

      context 'パラメータが妥当な場合' do
        it 'リクエストが成功すること' do
          pending '発展課題とする'
          post :create, params: { product: build(:product) }
          expect(response.status).to eq 302
        end
  
        it '商品が登録されること' do
          pending '発展課題とする'
          expect do
            post :create, params: { product: build(:product) }
          end.to change(Product, :count).by(1)
        end
  
        it 'トップページにリダイレクトすること' do
          pending '発展課題とする'
          post :create, params: { product: build(:product) }
          expect(response).to redirect_to('/')
        end
      end
  
      context 'パラメータが不正な場合' do
        it 'リクエストが成功すること' do
          pending '発展課題とする'
          post :create, params: { product: build(:product, name: nil) }
          expect(response.status).to eq 200
        end
  
        it '商品が登録されないこと' do
          pending '発展課題とする'
          expect do
            post :create, params: { product: build(:product, name: nil) }
          end.not_to change(Product, :count)
        end
  
        it 'newテンプレートで表示されること' do
          pending '発展課題とする'
          post :create, params: { product: build(:product, name: nil) }
          expect(response).to render_template :new
        end
  
        it 'エラーが表示されること' do
          pending '発展課題とする'
          post :create, params: { product: build(:product, name: nil) }
          expect(assigns(:product).errors.any?).to be_truthy
        end
      end
    end
  end

  describe 'GET #edit' do
    context 'ログイン前' do
      # 発展課題
    end
    
    context 'ログイン後' do
      before :each do
        user = create(:user)
        sign_in user
      end

      let!(:redshirt) { create(:redshirt) }

      it 'リクエストが成功すること' do
        pending '発展課題とする'
        get :edit, params: { id: redshirt }
        expect(response.status).to eq 200
      end

      it 'editテンプレートで表示されること' do
        pending '発展課題とする'
        get :edit, params: { id: redshirt }
        expect(response).to render_template :edit
      end

      it '@productが取得できていること' do
        get :show, params: { id: redshirt }
        expect(assigns(:product)).to eq redshirt
      end
    end
  end

  describe 'PUT #update' do
    context 'ログイン前' do
      # 発展課題
    end

    context 'ログイン後' do
      before :each do
        user = create(:user)
        sign_in user
      end

      let!(:redshirt) { create(:redshirt) }

      context 'パラメータが妥当な場合' do
        it 'リクエストが成功すること' do
          put :update, params: { id: redshirt, product: attributes_for(:blueshirt) }
          expect(response.status).to eq 302
        end
  
        it '商品が更新されること' do
          pending '発展課題とする'
          expect do
            put :update, params: { id: redshirt, product: attributes_for(:blueshirt) }
          end.to change(Product.find(redshirt.id), :name)
        end
  
        it 'トップページにリダイレクトすること' do
          put :update, params: { id: redshirt, product: attributes_for(:blueshirt) }
          expect(response).to redirect_to('/')
        end
      end
  
      context 'パラメータが不正な場合' do
        it 'リクエストが成功すること' do
          pending '発展課題とする'
          put :update, params: { id: redshirt, product: attributes_for(:blueshirt, name: nil) }
          expect(response.status).to eq 200
        end
  
        it '商品が変更されないこと' do
          expect do
            put :update, params: { id: redshirt, product: attributes_for(:blueshirt, name: nil) }
          end.not_to change(Product.find(redshirt.id), :name)
        end
  
        it 'editテンプレートで表示されること' do
          pending '発展課題とする'
          put :update, params: { id: redshirt, product: attributes_for(:blueshirt, name: nil) }
          expect(response).to render_template :edit
        end
  
        it 'エラーが表示されること' do
          pending '発展課題とする'
          put :update, params: { id: redshirt, product: attributes_for(:blueshirt, name: nil) }
          expect(assigns(:product).errors.any?).to be_truthy
        end
      end
    end

    context '出品したユーザでない' do
      it "出品したユーザ以外は更新できないこと" do
        # 発展課題
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログイン前' do
      # 発展課題
    end

    context 'ログイン後' do
      before :each do
        user = create(:user)
        sign_in user
      end

      let!(:redshirt) { create(:redshirt) }

      it 'リクエストが成功すること' do
        delete :destroy, params: { id: redshirt }
        expect(response.status).to eq 302
      end
  
      it '商品が削除されること' do
        pending '発展課題とする'
        expect do
          delete :destroy, params: { id: redshirt }
        end.to change(Product, :count).by(-1)
      end
  
      it 'トップページにリダイレクトすること' do
        delete :destroy, params: { id: redshirt }
        expect(response).to redirect_to('/')
      end
    end

    context '出品したユーザでない' do
      it "出品したユーザ以外は更新できないこと" do
        # 発展課題
      end
    end
  end
end
