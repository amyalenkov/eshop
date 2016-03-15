class RowCommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    comment = RowComment.create comment_params
    comment.user = current_user
    comment.save!
    @row = Row.find_by_id params[:row_comment][:row_id]
  end

  def destroy
    comment = RowComment.find_by id: params[:id], user_id: current_user.id
    @row = Row.find_by_id comment.row_id
    comment.destroy! unless comment.nil?
  end

  private

  def comment_params
    params.require(:row_comment).permit(:comment, :row_id)
  end
end
