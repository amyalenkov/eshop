require 'bundler/capistrano' # for bundler support
require 'capistrano'
require 'capistrano/deploy'

set :application, "ehop"
set :repository,  "git@github.com:amyalenkov/eshop.git"

set :user, 'root'
set :deploy_to, "/var/www/webapps/#{application}/public"
set :use_sudo, false

set :scm, :git

default_run_options[:pty] = true

role :web, "185.47.153.50"  # Your HTTP server, Apache/etc
role :app, "185.47.153.50"  # This may be the same as your `Web` server

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end










# require "bundler/capistrano"
# require 'bundler/setup'
#
# set :application, "eshop"
# set :repository,  "git@github.com:amyalenkov/eshop.git"
# set :user, "root"
#
# # set :applicationdir, "/var/www/webapps/#{application}"
# set :domain, "uzelok4you.by"
#
# set :scm, :git
# set :branch, "master"
# set :git_shallow_clone, 1
# set :scm_verbose, true
# # Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
#
# role :web, domain                          # Your HTTP server, Apache/etc
# role :app, domain                          # This may be the same as your `Web` server
# role :db,  domain, :primary => true # This is where Rails migrations will run
#
# set :deploy_to, applicationdir
# set :deploy_via, :remote_cache
#
# # if you're still using the script/reaper helper you will need
# # these http://github.com/rails/irs_process_scripts
#
# # If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end