# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
require File.expand_path('../environment', __FILE__)

set :output, "#{Rails.root}/log/cron_log.log"

# only for development stand
# env :PATH, ENV['PATH']
# env :GEM_PATH, ENV['GEM_PATH']
# end only for development stand

stop_record = Configure.find_by_name 'stop'
stop_time = stop_record.time
stop_day_of_week = stop_record.read_attribute('day_of_week')
stop_hour = stop_time.strftime('%H')
stop_minutes = stop_time.strftime('%M')
stop_cron = stop_minutes.to_s + ' ' + stop_hour.to_s + ' * * ' + stop_day_of_week.to_s

check_payment_record = Configure.find_by_name 'check_payment'
check_payment_time = check_payment_record.time
check_payment_day_of_week = check_payment_record.read_attribute('day_of_week')
check_payment_hour = check_payment_time.strftime('%H')
check_payment_minutes = check_payment_time.strftime('%M')
check_payment_cron = check_payment_minutes.to_s + ' ' + check_payment_hour.to_s + ' * * ' + check_payment_day_of_week.to_s

count_product_record = Configure.find_by_name 'count_product'
count_product_time = count_product_record.time
count_product_hour = count_product_time.strftime('%H')
count_product_minutes = count_product_time.strftime('%M')
count_product_cron = count_product_minutes.to_s + ' ' + count_product_hour.to_s + ' * * *'

every stop_cron do
  # rake "my:stop_task RAILS_ENV=production"
  rake "my:stop_task RAILS_ENV=development"
  # rake "my:stop_task"
end

every check_payment_cron do
  # rake "my:check_payment_task RAILS_ENV=production"
  rake "my:check_payment_task RAILS_ENV=development"
  # rake "my:check_payment_task"
end

every count_product_cron do
  # rake "my:count_product_task RAILS_ENV=production"
  rake "my:count_product_task RAILS_ENV=development"
  # rake "my:count_product_task"
end
