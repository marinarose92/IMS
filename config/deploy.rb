# Change these
server '157.230.225.77', port: 22, roles: [:web, :app, :db], primary: true

set :repo_url,        'https://github.com/marinarose92/IMS.git'
set :application,     'IMS'
set :user,            'deploy'
set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
# set :linked_files, %w{config/database.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}


# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma

# Set the roles where the let's encrypt process should be started
# Be sure at least one server has primary: true
# default value: :web
set :lets_encrypt_roles, :lets_encrypt

# Optionally set the user to use when installing on the remote system
# default value: nil
set :lets_encrypt_user, nil

# Set it to true to use let's encrypt staging servers
# default value: false
set :lets_encrypt_test, true

# Set your let's encrypt account email (required)
# The account will be created if no private key match
# default value: nil
set :lets_encrypt_email, nil

# Set the path to your let's encrypt account private key
# default value: "#{fetch(:lets_encrypt_email)}.account_key.pem"
set :lets_encrypt_account_key, "#{fetch(:lets_encrypt_email)}.account_key.pem"

# Set the domains you want to register (required)
# This must be a string of one or more domains separated a space - e.g. "example.com example2.com"
# default value: nil
set :lets_encrypt_domains, nil

# Set the path from where you are serving your static assets
# default value: "#{release_path}/public"
set :lets_encrypt_challenge_public_path, "#{release_path}/public"

# Set the path where the new certs are going to be saved
# default value: "#{shared_path}/ssl/certs"
set :lets_encrypt_output_path, "#{shared_path}/ssl/certs"

# Set the local path where the certs will be saved
# default value: "~/certs"
set :lets_encrypt_local_output_path, "~/certs"

# Set the minimum time that the cert should be valid
# default value: 30
set :lets_encrypt_days_valid, 15

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

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end