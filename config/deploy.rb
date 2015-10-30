# config valid only for Capistrano 3.1

set :repo_url,        'git@gitlab.pgs-soft.com:ruby-training/pgs-poker.git'
set :application,     'pgs-poker'

set :deploy_to,       '~/pgs-poker'
set :deploy_via,      :copy

set :linked_files,    %w{config/database.yml config/secrets.yml .env}
set :pty,             true

namespace :deploy do
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end


