lock '~> 3.17.1'
set :application, 'backend'
set :repo_url, 'git@github.com:client-stikubank/backend.git'
set :deploy_to, "/home/deploy/apps/#{fetch :application}"
set :pg_no_sudo, true
append :linked_files, 'config/database.yml', 'config/secrets.yml', '.env'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'vendor/bundle', 'storage', 'public/system', 'public/uploads', '.bundle'
set :keep_releases, 5

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end
