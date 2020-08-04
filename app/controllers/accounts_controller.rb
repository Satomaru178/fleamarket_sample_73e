class AccountsController < ApplicationController
  before_action :move_to_index,  only: [:index, :logout]
  before_action :set_categories, only: [:index, :logout, :likes]

  def index
  end

  def logout
  end

  def show
  end

  def likes
  end

  private

  def move_to_index
    redirect_to controller: :top, action: :index unless user_signed_in?
  end

  def set_categories
    @parents = Category.where(ancestry: nil)
  end
end
