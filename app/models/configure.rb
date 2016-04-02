class Configure < ActiveRecord::Base

  enum day_of_week: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]

  after_commit :set_cron

  def set_cron
    system 'bundle exec whenever -i'
    system 'bundle exec whenever -w'
  end

end
