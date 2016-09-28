class Configure < ActiveRecord::Base

  enum day_of_week: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]

  after_commit :set_cron

  def set_cron
    Rails.logger.warn 'set cron'

    system 'RAILS_ENV=production whenever -i'
    system 'RAILS_ENV=production whenever -w'

    # system 'bundle exec RAILS_ENV=production whenever -i'
    # system 'bundle exec RAILS_ENV=production whenever -w'

    Rails.logger.warn 'update cron'
  end

end
