class QuestionsController < ApplicationController

  before_action :authenticate_user!

  def show
    @questions = Question.all
  end

  def create
    question = Question.create comment_params
    question.user_id = current_user.id
    question.save!

    @id_question = params[:id]
    @questions = Question.all
  end

  def destroy
    question = Question.find_by id: params[:id], user_id: current_user.id
    @id_question = question.id_question
    question.destroy! unless answer.nil?
  end

  private

  def comment_params
    params.require(:question).permit(:name, :body)
  end

end
