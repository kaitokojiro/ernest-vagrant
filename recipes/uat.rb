# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

deps = 'make deps'
if %w(dev test).include? node['ernest']['environment']
  deps = 'make dev-deps || true && make deps'
end

node['ernest']['uat'].each do |name, attrs|
  org_dir = "/opt/go/src/github.com/#{attrs['org']}"
  dir = "#{org_dir}/#{name}"

  directory org_dir do
    owner node['server']['user']
    group node['server']['group']
    mode '0755'
    action :create
  end

  git dir do
    user node['server']['user']
    group node['server']['group']
    repository "git@github.com:#{attrs[:org]}/#{name}.git"
    revision attrs[:version]
    action :sync
  end

  execute "Install service #{name}" do
    command "su #{node['server']['user']} -l -c 'cd #{dir} && #{deps} && make install'"
    action :run
  end
end
