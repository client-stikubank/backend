require 'sshkit/sudo'
# Load DSL and Setup Up Stages
require 'capistrano/setup'
require 'capistrano/deploy'

# require 'capistrano/rails'
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git
require 'capistrano/bundler'
require 'capistrano/rbenv'
require 'capistrano/puma'
require 'capistrano/rails/migrations'
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Nginx
install_plugin Capistrano::Puma::Workers
install_plugin Capistrano::Puma::Systemd
# require 'capistrano/delayed_job'
set :rbenv_type, :user
set :rbenv_ruby, '3.1.2'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
