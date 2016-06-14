# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# Pre pull image
execute 'pull nats image' do
  command <<-EOH
  docker pull nats:latest
  EOH
end

template '/lib/systemd/system/nats.service' do # ~FC033
  source 'gnatsd.service.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  variables(
    name: 'nats',
    port: '4222',
    username: node['secrets']['nats']['username'],
    password: node['secrets']['nats']['password']
  )
end

service 'nats' do
  supports [:start, :stop, :restart]
  action [:enable, :start]
end

if %w(test dev).include? node['ernest']['environment']
  template '/lib/systemd/system/nats-test.service' do # ~FC033
    source 'gnatsd.service.erb'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
    variables(
      name: 'nats-test',
      port: '9999',
      username: node['secrets']['nats']['username'],
      password: node['secrets']['nats']['password']
    )
  end

  service 'nats-test' do
    supports [:start, :stop, :restart]
    action [:enable, :start]
  end
end
