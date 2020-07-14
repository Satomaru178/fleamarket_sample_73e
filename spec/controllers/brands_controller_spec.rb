require 'rails_helper'

describe BrandsController do
  describe 'GET #new' do
    it 'リクエストが成功すること' do
      get :new
      expect(response.status).to eq 200
    end

    it 'newテンプレートで表示されること' do
      get :new
      expect(response).to render_template :new
    end

    it '@brandがnewされていること' do
      get :new
      expect(assigns :brand).to_not be_nil
    end
  end
end
