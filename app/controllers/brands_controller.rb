class BrandsController < ApplicationController
  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      flash[:notice] = "ブランドを追加しました"
      redirect_to root_path
      return
    else
      flash[:alert] = "createエラー"
      render :new
      return
    end
  end

  private

  def brand_params
    params.require(:brand).permit(:name)
  end
end
