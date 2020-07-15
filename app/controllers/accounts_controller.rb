class AccountsController < ApplicationController
  before_action :move_to_index

  def index
  end

  def logout
  end

  def move_to_index
    redirect_to controller: :top, action: :index unless user_signed_in?
  end
end
