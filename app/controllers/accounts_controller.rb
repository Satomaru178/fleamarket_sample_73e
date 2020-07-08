class AccountsController < ApplicationController
  def index
    @user = User.all
    @account = Account.new(account_params)
  end

  def show
  end

  def destory
  end


end
