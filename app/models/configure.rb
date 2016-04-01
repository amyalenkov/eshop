class Configure < ActiveRecord::Base

  enum day_of_week: [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]

  after_update :set_cron

  def set_cron
    system 'bundle exec whenever -i'
    system 'bundle exec whenever -w'
  end

end
