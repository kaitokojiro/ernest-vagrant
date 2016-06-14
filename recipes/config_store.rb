# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

repo_version = node['ernest']['versions']['config-store']
rev = repo_version.nil? ? node['ernest']['version'] : repo_version

# Create config dir
directory '/etc/ernest' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

file '/etc/ernest/config.json' do # ~FC009: not based on a file
  content lazy {
    Chef::JSONCompat.to_json_pretty(redis: node['redis'],
                                    postgres: node['postgres']['database'],
                                    logstash: node['logstash']['dev'],
                                    monitor: node['monitor'],
                                    connectors: node['ernest']['connectors'],
                                    salt: node['salt'])
  }
  # Create Config Files
end

# Install service
['/opt/go/src', '/opt/go/src/github.com', "/opt/go/src/github.com/#{node['ernest']['organization']}"].each do |dir|
  directory dir do
    owner node['server']['user']
    group node['server']['group']
    mode '0755'
    action :create
  end
end

git "/opt/go/src/github.com/#{node['ernest']['organization']}/config-store" do
  user node['server']['user']
  group node['server']['group']
  repository "git@github.com:#{node['ernest']['organization']}/config-store.git"
  revision rev
  action :sync
end

execute 'install config-store' do
  command "su #{node['server']['user']} -l -c \"cd /opt/go/src/github.com/#{node['ernest']['organization']}/config-store && make deps && make install\""
  action :run
end

template '/lib/systemd/system/config-store.service' do # ~FC009 ~FC033
  source 'config_store.service.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  variables(
    lazy do
      {
        organization: node['ernest']['organization'],
        name: 'config-store',
        user: node['server']['user'],
        config: '/etc/ernest/config.json',
        natsuri: node['nats']['url']
      }
    end
  )
end

service 'config-store' do
  supports [:start, :stop, :restart]
  action [:enable, :start]
end
