# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

default['postgres']['server']['version'] = '5.5'
default['postgres']['server']['host'] =  node['server']['ip']
default['postgres']['server']['root_user'] = node['secrets']['postgres']['root_user']
default['postgres']['server']['root_password'] = node['secrets']['postgres']['root_password']

tables = %w(users
            clients
            datacenters
            services)

default['postgres']['database']['names'] = tables # tables.map{ |t| "%{env}_#{t}" }
default['postgres']['database']['user'] = node['secrets']['postgres']['user']
default['postgres']['database']['password'] = node['secrets']['postgres']['password']
default['postgres']['database']['url'] = "postgres://#{node['secrets']['postgres']['user']}:#{node['secrets']['postgres']['password']}@#{node['server']['ip']}"
