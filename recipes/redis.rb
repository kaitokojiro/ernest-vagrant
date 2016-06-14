# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# Pre pull image

execute 'pull redis image' do
  command <<-EOH
  docker pull redis:latest
  EOH
end

# Create directory for persistent data
directory '/etc/redis' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Create configuration file
template '/etc/redis/redis.conf' do # ~FC033
  source 'redis.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  variables(
    pass: node['secrets']['redis']['password']
  )
end

# Create directory for persistent data
directory '/var/redis' do
  owner 'root'
  group 'root'
  mode '0744'
  action :create
end

template '/lib/systemd/system/redis.service' do # ~FC033
  source 'redis.service.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  variables(
    datavol: '/var/redis'
  )
end

service 'redis' do
  supports [:start, :stop, :restart]
  action [:enable, :start]
end
