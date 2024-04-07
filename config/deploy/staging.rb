server '159.223.41.118', user: 'deploy', roles: %i[app db web]
set :rails_env, 'staging'
set :branch, 'main-backup'
set :migration_role, :db
set :migration_servers, -> { primary(fetch(:migration_role)) }
set :stage, :staging
set :rbenv_ruby, '3.1.2'
set :conditionally_migrate, true
set :puma_threads, [4, 16]
set :puma_workers, 0
set :pty, true
set :use_sudo, false
set :deploy_via, :remote_cache
set :puma_preload_app, true
set :puma_init_active_record, true
set :puma_user, fetch(:user)
set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_control_app, false
set :puma_default_control_app, "unix://#{shared_path}/tmp/sockets/pumactl.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'staging'))
set :puma_threads, [0, 16]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :puma_preload_app, false
set :puma_plugins, []
set :puma_tag, fetch(:application)
set :puma_restart_command, 'bundle exec puma'
set :puma_service_unit_name, "puma_#{fetch(:application)}_#{fetch(:stage)}"
set :puma_systemctl_user, :system
set :puma_enable_lingering, fetch(:puma_systemctl_user) != :system
set :puma_lingering_user, fetch(:user)
set :puma_service_unit_env_file, nil
set :puma_service_unit_env_vars, []
set :puma_phased_restart, false
set :puma_enable_socket_service, true
set :nginx_config_name, "#{fetch(:application)}_#{fetch(:stage)}"
set :nginx_flags, 'fail_timeout=0'
set :nginx_http_flags, fetch(:nginx_flags)
set :nginx_server_name, '159.223.41.118'
set :nginx_sites_available_path, '/etc/nginx/sites-available'
set :nginx_sites_enabled_path, '/etc/nginx/sites-enabled'
set :nginx_socket_flags, fetch(:nginx_flags)
set :nginx_ssl_certificate, "/etc/ssl/certs/#{fetch(:nginx_config_name)}.crt"
set :nginx_ssl_certificate_key, "/etc/ssl/private/#{fetch(:nginx_config_name)}.key"
set :nginx_use_ssl, false
set :nginx_use_http2, true
set :nginx_downstream_uses_ssl, false

set :bundle_roles, :all
set :bundle_config, { deployment: true }
set :bundle_servers, -> { release_roles(fetch(:bundle_roles)) }
# set :bundle_binstubs, -> { shared_path.join('bins') }
# set :bundle_path, -> { shared_path.join('bundle') }
set :bundle_flags, nil
set :bundle_path,       nil
set :bundle_without,    nil
set :bundle_env_variables, {}
set :bundle_clean_options, ''
set :bundle_check_before_install, true
