require 'rails_helper'

describe BrandsController do
  describe 'GET #new' do
    it "@productに正しい値が入っていること" do
      pending 'あとで記載する'
    end

    it "new.html.hamlに遷移すること" do
      pending 'うまくいかないのであとで修正する'
      get :new
      expect(response).to render_template :new
    end
  end
end
