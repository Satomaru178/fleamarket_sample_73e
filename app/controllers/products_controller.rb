class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :upload, :destroy]
  before_action :ensure_currect_user, only: [:edit, :update, :destroy]

  def index
    @products = Product.includes(:images).order('created_at DESC')
  end

  def new
    @product = Product.new
    @product.images.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path and return
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :explain,
      :condition_id,
      :costburden_id,
      :shippingorigin_id,
      :shippingperiod_id,
      :price,
      images_attributes: [:src, :_destroy, :id]
    ).merge(
      seller_ids: current_user.id
    )
  end

  def ensure_currect_user
    @product = Product.find(params[:id])
    @target = UserProduct.find_by(product_id: @product.id)

    if @target.seller_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to root_path
    else
      # nop
    end
  end
end
