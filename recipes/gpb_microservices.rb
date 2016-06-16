# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

ernest_path = "/opt/go/src/github.com/#{node['ernest']['organization']}"

directory ernest_path do
  owner node['server']['user']
  group node['server']['group']
  mode '0755'
  action :create
end

node['ernest']['services']['gpb'].each do |microservice|
  repo_version = node['ernest']['versions'][microservice]
  rev = repo_version.nil? ? node['ernest']['version'] : repo_version

  dir = "#{ernest_path}/#{microservice}"

  force_repo = node['ernest']['application']['repos'][microservice]

  git dir do
    user node['server']['user']
    group node['server']['group']
    repository force_repo.nil? ? "git@github.com:#{node['ernest']['organization']}/#{microservice}.git" : force_repo
    revision rev
    action :sync
  end
end

# INSTALL ALL MICROSERVICES
node['ernest']['services']['gpb'].each do |microservice|
  execute 'install microservice' do
    command "su #{node['server']['user']} -l -c 'cd #{ernest_path}/#{microservice} && make deps && make install'"
    action :run
  end
end
