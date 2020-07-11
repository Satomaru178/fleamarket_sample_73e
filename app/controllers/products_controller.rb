class ProductsController < ApplicationController
  # ログイン中のユーザしかできない
  before_action :authenticate_user!, only: [:new, :create, :edit, :upload, :destroy]

  # 出品したユーザしかできない
  before_action :ensure_currect_user, only: [:edit, :update, :destroy]

  # 親カテゴリの配列を用意する
  before_action :set_categories, only: [:new, :create, :edit, :update]

  def index
    @products = Product.includes(:images).order('created_at DESC')
  end

  def new
    @product = Product.new
    @product.images.new
    @product.build_brand
  end

  def create
    @product = Product.new(product_params)
    binding.pry
    if @product.save
      redirect_to root_path and return
    else
      flash[:notice] = "createエラー"
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      flash[:notice] = "updateエラー"
      render :edit
    end
  end

  def show
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  # 親カテゴリーが選択された時に動くアクション
  def get_category_children
    # 選択された親カテゴリーに対応する子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  # 子カテゴリーが選択された時に動くアクション
  def get_category_grandchildren
    #選択された子カテゴリーに対応する孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private

  def product_params
    params.require(:product).permit(
      :seller_id,
      :name,
      :explain,
      :category_id,
      :condition_id,
      :costburden_id,
      :shippingorigin_id,
      :shippingperiod_id,
      :price,
      images_attributes: [:id, :src, :_destroy],
      brand_attributes: [:id, :name],
    )
  end

  def category_params
    params.require(:category).permit(:id, :name, :ancestry)
  end

  def set_categories
    # セレクトボックスの初期値設定
    @category_parent_array = []
    # 親カテゴリー名を抽出し配列化
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def ensure_currect_user
    @product = Product.find(params[:id])

    if @product.seller_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to root_path
    else
      # nop
    end
  end
end
