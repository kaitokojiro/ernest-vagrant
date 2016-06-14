# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

usr = node['postgres']['database']['user']
pwd = node['postgres']['database']['password']
databases = node['postgres']['database']['names']

dbs = databases.join(',')
if node['ernest']['environment'] == 'dev'
  test = []
  databases.each do |d|
    test << "test_#{d}"
  end
  dbs = dbs + ',' + test.join(',')
end

# Ruby gem dependency
bash 'Install libpq-dev' do
  code <<-EOH
    DEBIAN_FRONTEND=noninteractive apt-get -y -q --force-yes install libpq-dev
  EOH
end

# Pre pull image

execute 'pull postgres image' do
  command <<-EOH
  docker pull r3labs/postgres:latest
  EOH
end

# Create directory for persistent data
directory '/var/postgres' do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

template '/lib/systemd/system/postgres.service' do # ~FC033
  source 'postgres.service.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  variables(
    datavol: '/var/postgres',
    user: usr,
    pass: pwd,
    databases: dbs
  )
end

service 'postgres' do
  supports [:start, :stop, :restart]
  action [:enable, :start]
end
