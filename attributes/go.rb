# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

default['go']['version'] = '1.6.2'
default['go']['owner'] = node['server']['user']
default['go']['group'] = node['server']['group']
default['go']['mode'] = '0755'
