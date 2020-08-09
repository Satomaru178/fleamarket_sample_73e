class CommentsController < ApplicationController

  before_action :set_comment, only: [:update, :destroy, :restore]
  before_action :check_user, only: [:update, :destroy, :restore]
  around_action :skip_bullet

  # コメント投稿用のアクション
  def create
    @comment = Comment.new(comment_params)
    @seller_of_product = @comment.product.seller
    if @comment.save
      respond_to do |format|
        format.json
      end
   else
     flash[:alert] = "保存に失敗しました"
     redirect_to product_path(params[:id])
   end
  end

  # コメント仮削除用のアクション
  def update
    @comment.update(delete_check: 1)
    redirect_to product_path(@comment.product.id)
  end

  # 仮削除したコメントの復元用のアクション
  def restore
    @comment.update(delete_check: 0)
    redirect_to product_path(@comment.product.id)
  end

  # 仮削除したコメントの完全削除用のアクション
  def destroy
    @comment.destroy
    redirect_to product_path(@comment.product.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment,:product_id).merge(user_id: current_user.id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def check_user
    unless @comment.product.seller == current_user
      flash[:alert] = "その操作は無効です"
      redirect_to root_path
    end
  end

  def skip_bullet
    Bullet.enable = false
    yield
  ensure
    Bullet.enable = true
  end

end
