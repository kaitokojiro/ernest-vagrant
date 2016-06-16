# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

directory '/opt/ernest' do
  owner node['server']['user']
  group node['server']['group']
  mode '0755'
  action :create
end

node['ernest']['services']['vcloud'].each do |service|
  repo_version = node['ernest']['versions'][service]
  rev = repo_version.nil? ? node['ernest']['version'] : repo_version

  force_repo = node['ernest']['application']['repos'][service]

  git "/opt/ernest/#{service}" do
    user node['server']['user']
    group node['server']['group']
    repository force_repo.nil? ? "git@github.com:#{node['ernest']['organization']}/#{service}.git" : force_repo
    revision rev
    action :sync
  end

  if ['router-creator-vcloud-connector', 'router-deleter-vcloud-connector', 'execution-run-salt-connector'].include? service
    execute 'sudo bundle install' do
      cwd "/opt/ernest/#{service}"
    end
  else
    execute 'sudo JRUBY_OPTS="--1.9 -Xcext.enabled=true" /usr/local/jruby-1.7.13/bin/jruby -S bundle install' do
      cwd "/opt/ernest/#{service}"
    end
  end

  execute 'build-project' do
    command "su #{node['server']['user']} -l -c 'git config --global url.\"git@github.com:\".insteadOf \"https://github.com/\" && cd /opt/ernest/#{service} && make deps'"
    action :run
  end
end
