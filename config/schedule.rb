# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
require File.expand_path('../environment', __FILE__)

set :output, "/home/amyalenkov/dev/eshop/log/cron_log.log"
cron_time = Configure.find_by_name 'stop'
every cron_time.value do
  command "echo 'you can use raw cron syntax too'"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
