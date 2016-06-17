# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

repo_version = node['ernest']['library-versions']['myst']
rev = repo_version.nil? ? 'develop' : repo_version

force_repo = node['ernest']['application']['repos']['myst']

directory node['ernest']['libraries']['path'] do
  owner node['server']['user']
  group node['server']['group']
  mode '0755'
  action :create
end

git '/opt/ernest-libraries/myst' do
  user node['server']['user']
  group node['server']['group']
  repository force_repo.nil? ? node['ernest']['libraries']['myst']['repo'] : force_repo
  revision rev
  action :sync
end
