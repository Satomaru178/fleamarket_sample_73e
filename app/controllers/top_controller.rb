class TopController < ApplicationController
  def index
    @parents = Category.where(ancestry: nil)
    @products = Product.includes(:images).where(buyer_id: nil).order("id DESC")
    @brandProducts = Product.includes(:images).where(buyer_id: nil).where(brand_id: 1).order("id DESC")
  end
end
