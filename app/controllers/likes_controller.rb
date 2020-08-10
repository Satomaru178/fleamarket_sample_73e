class LikesController < ApplicationController
  before_action :set_product

  def create
    @like = Like.create(user_id: current_user.id, product_id: @product.id)
    @product.reload
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, product_id: @product.id)
    @like.destroy
    @product.reload
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

end
