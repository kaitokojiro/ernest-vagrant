# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'socket'
require 'json'

hostname = Socket.gethostname
ip_address = Socket.ip_address_list.find { |ai| ai.ipv4? && !ai.ipv4_loopback? }.ip_address
version = File.open('VERSION', 'rb').read.strip

j = {
  'run_list' => ['recipe[ernest-vagrant]'],
  'server' => {
    'user'     => 'ernest',
    'group'    => 'ernest',
    'host_ip'  => ip_address,
    'hostname' => hostname
  },
  'flow' => {
    'version' => version
  }
}

puts j.to_json
