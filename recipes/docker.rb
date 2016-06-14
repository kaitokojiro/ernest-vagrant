# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

include_recipe 'apt-docker'

docker_installation_package 'default' do
  version '1.8.3'
  action :create
  package_options "--force-yes -o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-all'" # if Ubuntu for example
end

# Create docker group and add ernest to its members
# vagrant is not always present if we deploy using something other than vagrant

group 'docker' do
  members ['ernest', node['server']['user']].uniq
end
