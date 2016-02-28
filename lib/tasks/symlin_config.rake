task :symlink_config, :roles => :app do
  run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
end