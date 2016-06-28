# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# TODO, Move this to migrations related to groups and users on the application
#

bash 'install psql' do
  code 'apt-get install -q -y postgresql-client'
end

ernest_path = "/opt/go/src/github.com/#{node['ernest']['organization']}"

# Install each service
node['ernest']['services']['data'].each do |service|
  repo_version = node['ernest']['versions'][service]
  rev = repo_version.nil? ? node['ernest']['version'] : repo_version

  dir = "#{ernest_path}/#{service}"

  force_repo = node['ernest']['application']['repos'][service]

  git dir do
    user node['server']['user']
    group node['server']['group']
    repository force_repo.nil? ? "git@github.com:#{node['ernest']['organization']}/#{service}.git" : force_repo
    revision rev
    action :sync
  end

  execute 'install microservice' do
    command "su #{node['server']['user']} -l -c 'cd #{ernest_path}/#{service} && make deps && make install'"
    action :run
  end
end
