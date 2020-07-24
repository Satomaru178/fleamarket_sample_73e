class AccountsController < ApplicationController
  before_action :move_to_index,  only: [:index, :logout]
  before_action :set_categories, only: [:index, :logout]
  before_action :user_login, only: [:index, :logout]


  def index
    @parents = Category.where(ancestry: nil)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def logout
  end

  private

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
