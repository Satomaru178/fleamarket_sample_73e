class AddressesController < ApplicationController
  before_action :move_to_index,  only: [:edit, :update]
  before_action :set_categories, only: [:edit, :updat]
  before_action :user_login, only: [:edit, :updat]

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to controller: :accounts, action: :index
    else
      @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render action: :edit and return
    end
  end

  protected

  def address_params
    params.require(:address).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :zipcode, :prefecture, :city, :address, :address_other, :tell)
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
