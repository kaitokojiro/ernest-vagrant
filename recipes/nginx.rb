# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

include_recipe 'nginx'

template "#{node['nginx']['dir']}/sites-available/#{node['server']['hostname']}" do # ~FC033
  source 'nginx.conf.erb'
  action :create
  variables(hostname: node['server']['hostname'],
            ip: node['server']['ip'])
end

directory '/etc/nginx/ssl' do
  action :create
  mode 0644
end

cookbook_file 'ernest.local.key' do
  path "#{node['nginx']['dir']}/ssl/#{node['server']['hostname']}.key"
  mode 0644
  action :create
end

cookbook_file 'ernest.local.crt' do
  path "#{node['nginx']['dir']}/ssl/#{node['server']['hostname']}.crt"
  mode 0644
  action :create
end

nginx_site node['server']['hostname']
