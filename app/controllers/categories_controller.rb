class CategoriesController < ApplicationController
  # before_action :set_category, only: [:index, :category, :sub_category, :item]
  before_action :set_category, only: :show

  def index
    @parents = Category.where(ancestry: nil)
  end

  def show
    @items = @category.set_items
    @items = @items.where(buyer_id: nil).order("created_at DESC")
  end


  private
  def set_category
    @category = Category.find(params[:id])
     # 追記---------------------------------
    if @category.has_children?
      @category_links = @category.children
    else
      @category_links = @category.siblings
    end
  # -------------------------------------
  end

  # def set_category
  #   @category = Category.find(params[:id])
  #   @parents = Category.where(ancestry: nil)
  # end
end

