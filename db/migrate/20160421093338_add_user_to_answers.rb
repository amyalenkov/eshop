class AddUserToAnswers < ActiveRecord::Migration
  def change
    add_reference :answers, :user
  end
end
