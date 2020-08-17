class ProductsController < ApplicationController
  # ログイン中のユーザしかできない
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # 出品したユーザしかできない
  before_action :ensure_currect_user, only: [:edit, :update, :destroy]

  # 変数に親カテゴリを格納する
  before_action :set_parents, only: [:show, :fuzzy_search]

  # 親カテゴリの配列を用意する
  before_action :set_categories, only: [:index, :new, :create]

  # 子カテゴリと孫カテゴリの配列を用意する
  before_action :set_categories_edit, only: [:edit, :update]

  # ブランド一覧を用意する
  before_action :set_brands, only: [:index, :new, :create, :edit, :update]

  def index
    if params[:sort_order]
      sort = params[:sort_order]
    else
      sort = "created_at DESC"
    end

    @q = Product.ransack(params[:q])
    @products = @q.result.includes(:images).order(sort)
    @maximum_per_page = 63

    if @products.length <= @maximum_per_page
      @results = @products
    else
      @results = @products.page(params[:page]).per(@maximum_per_page)
    end
  end

  def new
    @product = Product.new
    @product.images.new
  end

  def create
    @product = Product.new(product_params)
    
    if @product.save
      flash[:notice] = "商品を出品しました"
      redirect_to root_path
      return
    else
      # renderで戻された時画像入力フォームがなくなってしまう事象への対策
      @product.images.new

      flash[:alert] = "商品を出品できませんでした"
      render :new
      return
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      flash[:notice] = "商品を編集しました"
      redirect_to root_path
      return
    else
      flash[:alert] = "商品を編集できませんでした"
      render :edit
      return
    end
  end

  def show
    @product = Product.find(params[:id])
    @products = Product.includes(:images).where(category_id: @product.category_id).where.not(id: @product.id).order('created_at DESC').first(3)
    @comment = Comment.new
    @comments = @product.comments
  end

  def destroy
    if @product.destroy
      flash[:notice] = "商品を削除しました"
    else
      flash[:alert] = "商品を削除できませんでした"
    end

    redirect_to root_path
    return
  end

  def fuzzy_search
    sort = "created_at DESC"
    @products = Product.search(params[:keyword])
    @maximum_per_page = 63

    if @products.length <= @maximum_per_page
      @results = @products.includes(:images).order(sort)
    else
      @results = @products.includes(:images).order(sort).page(params[:page]).per(@maximum_per_page)
    end
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
      :brand_id,
      :condition_id,
      :costburden_id,
      :shippingorigin_id,
      :shippingperiod_id,
      :price,
      images_attributes: [:id, :src, :_destroy],
      brand_attributes: [:id, :name],
    )
  end

  def ensure_currect_user
    @product = Product.find(params[:id])

    if @product.seller_id != current_user.id
      flash[:alert] = "権限がありません"
      redirect_to root_path
    else
      prohibit_purchased_product
    end
  end

  def prohibit_purchased_product
    if @product.buyer_id
      flash[:alert] = "購入済の商品は編集または削除できません"
      redirect_to root_path
    else
      # nop
    end
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  def set_categories
    set_parents

    # セレクトボックスの初期値設定
    @category_parent_array = []

    # 親カテゴリー名を抽出し配列化
    @parents.each do |parent|
      @category_parent_array << parent.name
    end
  end

  def set_categories_edit
    set_categories

    # productが所属する子カテゴリーの一覧を配列で取得
    @category_child_array = @product.category.parent.parent.children

    # productが所属する孫カテゴリーの一覧を配列で取得
    @category_grandchild_array = @product.category.parent.children
  end

  def set_brands
    @brands = Brand.all
  end
end
