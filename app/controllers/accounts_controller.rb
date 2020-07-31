class AccountsController < ApplicationController
  before_action :move_to_index,  only: [:index, :edit ,:update, :logout, :show]
  before_action :set_categories, only: [:index, :edit ,:update, :logout, :show]
  before_action :user_login, only: [:index, :edit ,:update, :logout, :show]

  def index
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
