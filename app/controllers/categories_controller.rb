class CategoriesController < ApplicationController
  before_action :set_category, only: :show

  def index
    @parents = Category.where(ancestry: nil)
  end

  def show
    @products = @category.set_items
    @items = @products.where(buyer_id: nil).order("id DESC")
  end


  private
  def set_category
    @category = Category.find(params[:id])
    # カテゴリリンクの出し分け
    if @category.has_children?
      @category_links = @category.children
    else
      @category_links = nil
    end

  end

end

