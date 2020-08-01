require 'rails_helper'

describe ProductsController do
  describe 'GET #new' do
    it 'リクエストが成功すること' do
      pending '発展課題とする'
      get :new
      expect(response.status).to eq 200
    end

    it 'newテンプレートで表示されること' do
      pending '発展課題とする'
      get :new
      expect(response).to render_template :new
    end

    it '@productがnewされていること' do
      pending '発展課題とする'
      get :new
      expect(assigns :product).not_to be_nil
    end
  end

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
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
        expect do
          post :create, params: { product: build(:product, name:nil) }
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

  describe 'GET #edit' do
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
  end

  describe 'PUT #update' do
    let!(:redshirt) { create(:redshirt) }

    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        pending '発展課題とする'
        put :update, params: { id: :redshirt, product: attributes_for(:blueshirt) }
        expect(response.status).to eq 302
      end

      it '商品が更新されること' do
        pending '発展課題とする'
        expect do
          put :update, params: { id: :redshirt, product: attributes_for(:blueshirt) }
        end.to change { Product.find(:redshirt.id) }
      end

      it 'トップページにリダイレクトすること' do
        pending '発展課題とする'
        put :update, params: { id: :redshirt, product: attributes_for(:blueshirt) }
        expect(response).to redirect_to('/')
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        pending '発展課題とする'
        put :update, params: { id: :redshirt, product: attributes_for(:blueshirt, name: nil) }
        expect(response.status).to eq 200
      end

      it '商品が変更されないこと' do
        pending '発展課題とする'
        expect do
          put :update, params: { id: :redshirt, product: attributes_for(:blueshirt, name: nil) }
        end.not_to change(Product.find(:redshirt.id), :name)
      end

      it 'editテンプレートで表示されること' do
        pending '発展課題とする'
        put :update, params: { id: :redshirt, product: attributes_for(:blueshirt, name: nil) }
        expect(response).to render_template :edit
      end

      it 'エラーが表示されること' do
        pending '発展課題とする'
        put :update, params: { id: :redshirt, product: attributes_for(:blueshirt, name: nil) }
        expect(assigns(:product).errors.any?).to be_truthy
      end
    end
  end

  describe 'GET #show' do
    it "@productに正しい値が入っていること" do
      product = create(:product)
      get :show, params: { id: product }
      expect(assigns(:product)).to eq product
    end
    it "show.html.hamlに遷移すること" do
      product = create(:product)
      get :show, params: {id: product}
      expect(response).to render_template :show  
    end
  end

  describe 'DELETE #destroy' do
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
      pending '発展課題とする'
      delete :destroy, params: { id: redshirt }
      expect(response).to redirect_to('/')
    end
  end
end
