class RowCommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    comment = RowComment.create comment_params
    comment.user = current_user
    comment.save!
    @row = Row.find_by_id params[:row_comment][:row_id]
  end

  private

  def comment_params
    params.require(:row_comment).permit(:comment, :row_id)
  end
end
