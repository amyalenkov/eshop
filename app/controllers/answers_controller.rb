class AnswersController < ApplicationController

  before_action :authenticate_user!

  def create
    answer = Answer.create comment_params
    answer.user_id = current_user.id
    answer.save!
    @id_question = params[:answer][:id_question]
  end

  def destroy
    answer = Answer.find_by id: params[:id], user_id: current_user.id
    @id_question = answer.id_question
    answer.destroy! unless answer.nil?
  end

  private

  def comment_params
    params.require(:answer).permit(:body, :id_question)
  end

end
