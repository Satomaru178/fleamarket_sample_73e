class CategoriesController < ApplicationController
  before_action :set_category, only: :show
  before_action :set_category_header, only: [:index, :show]
  before_action :user_login, only: [:index, :show]

  def index
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

  def set_category_header
    @parents = Category.where(ancestry: nil)
  end

  def user_login
    @account = current_user[:id]
    @profile = current_user.account
  end
end

