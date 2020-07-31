class TopController < ApplicationController
  def index
    @parents = Category.where(ancestry: nil)
    @profile = current_user.account
  end
end
