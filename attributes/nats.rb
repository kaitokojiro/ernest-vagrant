# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

default['gnatsd']['version'] = '0.7.2'
default['gnatsd']['base_url'] = 'https://github.com/nats-io/gnatsd/releases/download/'
default['gnatsd']['file'] = "/gnatsd-v#{default['gnatsd']['version']}-linux-amd64.tar.gz"
version = default['gnatsd']['version']
base_url = default['gnatsd']['base_url']
file = default['gnatsd']['file']
default['gnatsd']['url'] = "#{base_url}v#{version}/#{file}"

if node['secrets']['nats']['username'] != ''
  default['nats']['url'] = "nats://#{node['secrets']['nats']['username']}:#{node['secrets']['nats']['password']}@#{node['server']['hostname']}:4222"
  default['nats']['dev']['url'] = "nats://#{node['secrets']['nats']['username']}:#{node['secrets']['nats']['password']}@#{node['server']['hostname']}:4222"
  default['nats']['test']['url'] = "nats://#{node['secrets']['nats']['username']}:#{node['secrets']['nats']['password']}@#{node['server']['hostname']}:9999"
  default['nats']['staging']['url'] = "nats://#{node['secrets']['nats']['username']}:#{node['secrets']['nats']['password']}@#{node['server']['hostname']}:4222"
else
  default['nats']['url'] = "nats://#{node['server']['hostname']}:4222"
  default['nats']['dev']['url'] = "nats://#{node['server']['hostname']}:4222"
  default['nats']['test']['url'] = "nats://#{node['server']['hostname']}:9999"
  default['nats']['staging']['url'] = "nats://#{node['server']['hostname']}:4222"
end
