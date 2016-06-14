# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

home_dir = "/home/#{node['server']['user']}"

directory "#{home_dir}/.ssh" do
  owner node['server']['user']
  group node['server']['group']
  mode '0700'
  recursive true
end

cookbook_file 'id_rsa.erb' do
  owner node['server']['user']
  group node['server']['group']
  mode 0400
  path "#{home_dir}/.ssh/id_rsa"
  action :create_if_missing
  ignore_failure true
end

bash 'ssh_known_hosts' do
  user node['server']['user']
  cwd home_dir
  code <<-EOH
    ssh-keyscan github.com >> #{home_dir}/.ssh/known_hosts
    EOH
end
