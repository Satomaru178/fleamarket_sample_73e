class TopController < ApplicationController
  def index
    @parents = Category.where(ancestry: nil)
    @products = Product.includes(:images).where(buyer_id: null).order(:id :desc)
  end
end
