class Configure < ActiveRecord::Base

  after_update :set_cron

  def set_cron
    system 'bundle exec whenever -i'
    system 'bundle exec whenever -w'
  end

end
