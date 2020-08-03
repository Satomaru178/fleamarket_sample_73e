class LikesController < ApplicationController
  before_action :set_product

  def create
    @like = Like.create(user_id: current_user.id, product_id: params[:product_id])
    @likes = Like.where(product_id: params[:product_id])
    @product.reload
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, product_id: params[:product_id])
    like.destroy
    @likes = Like.where(product_id: params[:product_id])
    @product.reload
  end

  private

  def set_product
    @product = product.find(params[:product_id])
  end

end