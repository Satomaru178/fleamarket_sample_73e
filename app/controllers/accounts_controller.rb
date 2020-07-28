class AccountsController < ApplicationController
  before_action :move_to_index,  only: [:index, :new, :edit , :logout]
  before_action :set_categories, only: [:index, :new, :edit , :logout]
  before_action :user_login, only: [:index, :new, :edit , :logout]


  def index
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
  end

  def update
  end

  def logout
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
