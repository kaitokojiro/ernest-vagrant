# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# TODO, Move this to migrations related to clients and users on the application
#
usr = node['postgres']['database']['user']

bash 'install psql' do
  code 'apt-get install -q -y postgresql-client'
end

template '/tmp/clients.sql' do # ~FC033
  source 'clients.sql.erb'
  mode '0440'
  owner node['server']['user']
  group node['server']['group']
  variables(client_id:      node['ernest']['application']['client_id'],
            client_name:    node['ernest']['application']['client_name'],
            env:            node['ernest']['environment'])
end

template '/tmp/users.sql' do # ~FC033
  source 'users.sql.erb'
  mode '0440'
  owner node['server']['user']
  group node['server']['group']
  variables(client_id:      node['ernest']['application']['client_id'],
            user_id:        node['ernest']['application']['user_id'],
            user_name:      node['ernest']['application']['user_name'],
            user_email:     node['ernest']['application']['user_email'],
            user_password:  Digest::SHA2.hexdigest(node['ernest']['application']['user_salt'] + node['ernest']['application']['user_password']),
            user_salt:      node['ernest']['application']['user_salt'],
            env:            node['ernest']['environment'])
end

host = node['postgres']['server']['host']

bash 'create clients' do
  code "psql -h #{host} -U #{usr} clients -f /tmp/clients.sql"
end

bash 'create users' do
  code "psql -h #{host} -U #{usr} users -f /tmp/users.sql"
end

if node['ernest']['environment'] == 'dev'
  bash 'create dev clients' do
    code "psql -h #{host} -U #{usr} test_clients -f /tmp/clients.sql"
  end

  bash 'create dev users' do
    code "psql -h #{host} -U #{usr} test_users -f /tmp/users.sql"
  end
end

# Install each service
node['ernest']['services']['data'].each do |service|
  repo_version = node['ernest']['versions'][service]
  rev = repo_version.nil? ? node['ernest']['version'] : repo_version

  force_repo = node['ernest']['application']['repos'][service]

  directory '/opt/ernest' do
    owner node['server']['user']
    group node['server']['group']
    mode '0755'
    action :create
  end

  git "/opt/ernest/#{service}" do
    user node['server']['user']
    group node['server']['group']
    repository force_repo.nil? ? "git@github.com:#{node['ernest']['organization']}/#{service}.git" : force_repo
    revision rev
    action :sync
  end

  execute 'bundle install' do
    cwd "/opt/ernest/#{service}"
  end
end
