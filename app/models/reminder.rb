class Reminder < ActiveRecord::Base

  after_commit :update_user_message

  def update_user_message
    User.where(choice_delivery: true).update_all(choice_delivery: false)
    User.where(after_stop: true).update_all(after_stop: false)
    User.where(info_stop: true).update_all(info_stop: false)
    User.where(info_delivery: true).update_all(info_delivery: false)
  end

end
