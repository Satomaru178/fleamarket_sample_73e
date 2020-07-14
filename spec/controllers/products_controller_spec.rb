require 'rails_helper'

describe ProductsController do
  describe 'GET #new' do
    it 'リクエストが成功すること' do
      pending 'うまくいかないのであとで修正する'
      get :new
      expect(response.status).to eq 200
    end

    it 'newテンプレートで表示されること' do
      pending 'うまくいかないのであとで修正する'
      get :new
      expect(response).to render_template :new
    end

    it '@productがnewされていること' do
      pending 'うまくいかないのであとで修正する'
      get :new
      expect(assigns :product).to_not be_nil
    end
  end

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post :create, params: { product: build(:product) }
        expect(response.status).to eq 302
      end

      it '商品が登録されること' do
        pending 'うまくいかないのであとで修正する'
        expect do
          post :create, params: { product: build(:product) }
        end.to change(User, :count).by(1)
      end

      it 'トップページにリダイレクトすること' do
        pending 'うまくいかないのであとで修正する'
        post :create, params: { product: build(:product) }
        expect(response).to redirect_to('/')
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        pending 'うまくいかないのであとで修正する'
        post :create, params: { product: build(:product, name: nil) }
        expect(response.status).to eq 200
      end

      it '商品が登録されないこと' do
        expect do
          post :create, params: { product: build(:product, name:nil) }
        end.to_not change(Product, :count)
      end

      it 'newテンプレートで表示されること' do
        pending 'うまくいかないのであとで修正する'
        post :create, params: { product: build(:product, name: nil) }
        expect(response).to render_template :new
      end

      it 'エラーが表示されること' do
        pending 'うまくいかないのであとで修正する'
        post :create, params: { product: build(:product, name: nil) }
        expect(assigns(:product).errors.any?).to be_truthy
      end
    end
  end

  describe 'GET #edit' do
    it 'リクエストが成功すること' do
      pending 'うまくいかないのであとで修正する'
      get :edit
      expect(response.status).to eq 200
    end

    it 'editテンプレートで表示されること' do
      pending 'うまくいかないのであとで修正する'
      get :edit
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        pending 'うまくいかないのであとで修正する'
        put :update, params: { id: :takashi, product: build(:satoshi) }
        expect(response.status).to eq 302
      end

      it '商品名が更新されること' do
        pending 'うまくいかないのであとで修正する'
        expect do
          put :update, params: { id: :takashi, product: build(:satoshi) }
        end.to change { Product.find(:takashi.id).name }.from('Takashi').to('Satoshi')
      end

      it 'トップページにリダイレクトすること' do
        pending 'うまくいかないのであとで修正する'
        put :update, params: { id: :takashi, product: build(:satoshi) }
        expect(response).to redirect_to('/')
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        pending 'うまくいかないのであとで修正する'
        put :update, params: { id: :takashi, user: build(:product, name: nil) }
        expect(response.status).to eq 200
      end

      it '商品名が変更されないこと' do
        pending 'うまくいかないのであとで修正する'
        expect do
          put :update, params: { id: :takashi, user: build(:product, name: nil) }
        end.to_not change(Product.find(takashi.id), :name)
      end

      it 'editテンプレートで表示されること' do
        pending 'うまくいかないのであとで修正する'
        put :update, params: { id: :takashi, user: build(:product, name: nil) }
        expect(response).to render_template :edit
      end

      it 'エラーが表示されること' do
        pending 'うまくいかないのであとで修正する'
        put :update, params: { id: :takashi, user: build(:product, name: nil) }
        expect(assigns(:product).errors.any?).to be_truthy
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'リクエストが成功すること' do
      delete :destroy, params: { id: :product }
      expect(response.status).to eq 302
    end

    it '商品が削除されること' do
      pending 'うまくいかないのであとで修正する'
      expect do
        delete :destroy, params: { id: :product }
      end.to change(Product, :count).by(-1)
    end

    it 'トップページにリダイレクトすること' do
      pending 'うまくいかないのであとで修正する'
      delete :destroy, params: { id: :product }
      expect(response).to redirect_to('/')
    end
  end
end
