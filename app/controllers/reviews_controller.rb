class ReviewsController < ApplicationController

  # before_action :authenticate_user!

  def show
    @reviews = Review.all
  end

  def create
    review = Review.create comment_params
    review.user_id = current_user.id
    review.save!

    @id_review = params[:name]
    @reviews = Review.all
  end

  def destroy
    review = Review.find_by id: params[:id], user_id: current_user.id
    @id_review = review.id_review
    review.destroy! unless answer.nil?
  end

  private

  def comment_params
    params.require(:review).permit(:name, :body)
  end

end
