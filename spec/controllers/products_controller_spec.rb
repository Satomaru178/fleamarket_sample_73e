require 'rails_helper'

describe ProductsController do
  describe 'GET #new' do
    it "@productに正しい値が入っていること" do
      pending 'あとで記載する'
    end

    it "new.html.hamlに遷移すること" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "edit.html.htmlに遷移すること" do
      product = create(:product)
      get :edit, params: { id: product }
      expect(response).to render_template :edit
    end
  end
end
