# TBD

server 'xxxx', user: 'deploy', roles: %i[app db web]
set :rails_env, 'production'
set :branch, 'master'
set :migration_role, :db
set :migration_servers, -> { primary(fetch(:migration_role)) }
set :conditionally_migrate, true
set :stage, :production
