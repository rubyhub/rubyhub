# RVM
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, 'ree-1.8.7-2010.02@rubyhub'

# Bundler
require 'bundler/capistrano'

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

set :user, 'leonid'
set :application, 'rubyhub'
set :deploy_to, '/home/leonid/www/rubyhub'
set :repository, 'git://github.com/rubyhub/rubyhub.git'
set :scm, :git
set :branch, 'master'

set :deploy_via, :remote_cache

role :web, 'todo.in.ua', :primary => true
role :app, 'todo.in.ua', :primary => true
role :db, 'todo.in.ua', :primary => true

default_run_options[:pty] = true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{release_path}/tmp/restart.txt"
  end

  desc "Make symlinks"
  task :update_symlinks do
    ['database.yml', 'keys.yml'].each do |filename|
      run "ln -fs #{shared_path}/config/#{filename} #{release_path}/config/#{filename}"
    end

    ['tmp'].each do |dir|
      run "ln -fs #{deploy_to}/#{shared_dir}/#{dir} #{release_path}/#{dir}"
    end
  end

  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
  
  task :jammit do
    run "cd #{release_path} && rake jammit:package RAILS_ENV=production"
  end
end

after "deploy:update_code", "deploy:update_symlinks"
after "deploy:update_code", "deploy:trust_rvmrc" 
after "deploy:update_code", "deploy:jammit"
