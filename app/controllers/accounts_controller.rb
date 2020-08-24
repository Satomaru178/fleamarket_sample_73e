class AccountsController < ApplicationController
  before_action :move_to_index,  only: [:index, :new, :create, :edit, :update, :logout, :mypage]
  before_action :set_categories, only: [:index, :new, :create, :edit, :update, :logout, :show, :mypage, :likes]
  before_action :user_login, only: [:index, :new, :create, :edit, :update, :logout, :mypage]

  def index
    if @profile.blank?
    else
      redirect_to action: :mypage
    end
    @products = Product.where(seller_id: current_user.id)
    @products_buy = Product.where(buyer_id: current_user.id)
  end

  def new
    if @profile.blank?
      @profile = Account.new
    else
      redirect_to action: :edit
    end
  end

  def create
    @profile = Account.create(account_params)
    if @profile.save
      redirect_to action: :mypage
    else
      redirect_to action: :new
    end
  end

  def edit
    if @profile.blank?
      redirect_to action: :new
    else
    end
  end

  def update
    if @profile.update(account_params)
      redirect_to controller: :accounts, action: :index
    else
      @profile.valid?
      flash.now[:alert] = "入力された情報は正しくありません"
      render action: :edit and return
    end
  end

  def logout
  end

  def show
    @profile = Account.find(params[:id])
    @user = @profile.user
    @products = Product.where(seller_id: current_user.id)
  end


  def mypage
    if @profile.blank?
      redirect_to action: :index
    else
    end
    @products = Product.where(seller_id: current_user.id)
    @products_buy = Product.where(buyer_id: current_user.id)

  end

  def likes
  end

  private

  def account_params
    params.require(:account).permit(:icon_image, :background_image, :profile).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to controller: :top, action: :index unless user_signed_in?
  end

  def set_categories
    @parents = Category.where(ancestry: nil)
  end

  def user_login
    @account = current_user[:id]
    @profile = current_user.account
  end
end
