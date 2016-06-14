# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

default['logstash']['dev'] = {
  'hostname' => node['server']['hostname'],
  'port' => 5000,
  'timeout' => 50_000
}

default['logstash']['test'] = {
  'hostname' => node['server']['ip'],
  'port' => 5000,
  'timeout' => 50_000
}
