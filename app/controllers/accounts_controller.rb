class AccountsController < ApplicationController
  before_action :move_to_index,  only: [:index, :new, :edit , :logout, :show, :profile]
  before_action :set_categories, only: [:index, :new, :edit , :logout, :show, :profile]
  before_action :user_login, only: [:index, :new, :edit , :logout, :show, :profile]


  def index
    @profile = current_user.account
    if @profile.blank?
    else
      redirect_to action: :profile
    end
  end

  def new
    @profile = Account.new
  end

  def create
    @profile = Account.create(account_params)
    if @profile.save
      redirect_to action: :index
    else
      redirect_to action: :new
    end
  end

  def edit
    @profile = current_user.account
    if @profile.blank?
      redirect_to action: :new
    else
    end
  end

  def update
    @profile = current_user.account
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
  end

  def profile
    @profile = current_user.account
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
  end
end
