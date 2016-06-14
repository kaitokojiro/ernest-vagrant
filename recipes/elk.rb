# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# Pull images
%w(elasticsearch logstash kibana).each do |image|
  execute "pull #{image} image" do
    command <<-EOH
    docker pull #{image}:latest
    EOH
  end
end

# Create elasticsearch volume directory
directory '/var/elasticsearch' do
  owner 'root'
  group 'root'
  mode '0744'
  action :create
end

# Create config directories for docker containers
%w(kibana logstash).each do |dir|
  directory "/etc/#{dir}" do
    owner node['server']['user']
    group node['server']['group']
    mode '0755'
    action :create
  end
end

# Create logstash and kibana config
template '/etc/logstash/logstash.conf' do # ~FC033
  source 'logstash.conf.erb'
  owner node['server']['user']
  group node['server']['group']
  mode '0755'
  action :create
end

cookbook_file '/etc/kibana/kibana.yml' do
  source 'kibana.yml'
  owner node['server']['user']
  group node['server']['group']
  mode '0755'
  action :create
end

# ELASTICSEARCH
template '/lib/systemd/system/elasticsearch.service' do # ~FC033
  source 'elasticsearch.service.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  variables(
    datavol: '/var/elasticsearch',
    hostname: 'localhost'
  )
end

service 'elasticsearch' do
  supports [:start, :stop, :restart]
  action [:enable, :start]
end

# LOGSTASH
template '/lib/systemd/system/logstash.service' do # ~FC033
  source 'logstash.service.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  variables hostname: 'localhost'
end

service 'logstash' do
  supports [:start, :stop, :restart]
  action [:enable, :start]
end

# KIBANA
template '/lib/systemd/system/kibana.service' do # ~FC033
  source 'kibana.service.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  variables(
    hostname: 'localhost',
    version: node['kibana']['version']
  )
end

service 'kibana' do
  supports [:start, :stop, :restart]
  action [:enable, :start]
end

execute 'ensure elasticsearch startup' do # ~FC041: bla
  command 'curl -i -s http://localhost:9200'
  retries 25
  retry_delay 15
end

# Define default index based on service
execute 'setup-default-index' do # ~FC041: bla
  command <<-EOH
curl -XPUT http://localhost:9200/.kibana/index-pattern/service -d '{"title" : "service"}'
curl -XPOST http://localhost:9200/.kibana/config/#{node['kibana']['version']} -d '{"defaultIndex" : "service"}'
  EOH
end
