class AddUserToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :user
  end
end
