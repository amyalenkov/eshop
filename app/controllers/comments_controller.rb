class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    comment = Comment.create comment_params
    comment.user = current_user
    comment.save!
    @product = Product.find_by_id params[:comment][:product_id]
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :product_id)
  end
end
