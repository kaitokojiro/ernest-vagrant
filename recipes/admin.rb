# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

ernest_path = "/opt/go/src/github.com/r3labs"

directory ernest_path do
  owner node['server']['user']
  group node['server']['group']
  mode '0755'
  action :create
end

git "#{ernest_path}/natsc" do
  user node['server']['user']
  group node['server']['group']
  repository "git@github.com:r3labs/natsc.git"
  revision 'master'
  action :sync
end

execute 'install natsc' do
  command "su #{node['server']['user']} -l -c 'cd #{ernest_path}/natsc && make deps && make install'"
  action :run
end

execute 'add admin group' do
  command "/opt/go/bin/natsc request -s #{node['nats']['url']} -t 5 -r 5 'group.set' '{\"id\":\"1\",\"name\": \"admin\"}'"
  action :run
end

execute 'add admin user' do
  command "/opt/go/bin/natsc request -s #{node['nats']['url']} -t 5 -r 5 'user.set' '{\"group_id\": 1, \"username\": \"admin\", \"password\": \"#{node['ernest']['application']['user_password']}\", \"admin\":true}'"
  action :run
end
