class CreditcardsController < ApplicationController
  before_action :move_to_index, only: [:index, :new, :create, :show, :delete]
  before_action :set_categories, only: [:index, :new, :create, :show, :delete]
  before_action :user_login, only: [:index, :new, :create, :show, :delete]

  require "payjp"

  def index
    @card = Creditcard.where(user_id: current_user.id)
    if @card.exists?
      redirect_to action: "show"
    end
  end

  def new
    @card = Creditcard.where(user_id: current_user.id)
    if @card.exists?
      redirect_to action: "show"
    end
  end

  def create
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    if params["payjp_token"].blank?
      redirect_to action: "index"
    else
      customer = Payjp::Customer.create(
        email: current_user.email,
        card: params["payjp_token"],
        metadata: {user_id: current_user.id}
      )
      @card = Creditcard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "new"
      end
    end
  end

  def show
    @card = Creditcard.where(user_id: current_user.id).first
    if @card.blank?
      render action: :index
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @customer_card = customer.cards.retrieve(@card.card_id)
      @exp_month = @customer_card.exp_month.to_s
      @exp_year = @customer_card.exp_year.to_s.slice(2,3)
      @card_brand = @customer_card.brand
      case @card_brand
      when "Visa"
        @card_src = "visa.svg"
      when "JCB"
        @card_src = "jcb.svg"
      when "MasterCard"
        @card_src = "master.svg"
      when "American Express"
        @card_src = "amex.svg"
      when "Diners Club"
        @card_src = "diners.svg"
      when "Discover"
        @card_src = "discover.svg"
      end
    end
  end

  def delete
    @card = Creditcard.find_by(user_id: current_user.id)
    if @card.blank?
      redirect_to action: "index"
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
      redirect_to action: "index"
    end
  end

  def pay
    @product = product.params[:id]
    @card = Creditcard.where(user_id: current_user.id)
    if @product.costburden_id == 1
      postage = 0
    elsif @product.costburden_id == 2
      postage = 200
    else
      postage = 0
    end
    Payjp.api_key = ENV['PAYJP_PROVATE_KEY']
    Payjp: :Charge.create(
      :amount => @product.price + postage
      :customer => @card.customer_id
      :currency => 'jpy' 
    )
    flash[:notice] = "商品を購入しました"
    @product.buyer_id = current_user.id
    redirect_to root_path
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
    @profile = current_user.account
  end
end
