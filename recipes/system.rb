# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

bash 'remove-cloudinit' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    sudo apt-get remove --auto-remove lxcfs cloud-initramfs-dyn-netconf cloud-initramfs-copymods cloud-image-utils cloud-guest-utils cloud-init  puppet puppet-common -y
    sudo apt-get purge --auto-remove lxcfs cloud-initramfs-dyn-netconf cloud-initramfs-copymods cloud-image-utils cloud-guest-utils cloud-init puppet puppet-common -y
  EOH
end

package 'unzip'
package 'ntp'
package 'build-essential'
package 'bison'
package 'vim-nox'
package 'git'
package 'libssl-dev'
package 'autoconf'
package 'libyaml-dev'
package 'libreadline6-dev'
package 'zlib1g-dev'
package 'libncurses5-dev'
package 'libffi-dev'
package 'libgdbm3'
package 'libgdbm-dev'
package 'curl'
package 'libnss-mdns'

hostname = node['server']['hostname']

file '/etc/hostname' do
  content "#{hostname}\n"
end

# Setup ENV variables
nats_uri = "nats://#{node['server']['hostname']}:4222"
if node['secrets']['nats']['username'] != ''
  nats_uri = "nats://#{node['secrets']['nats']['username']}:#{node['secrets']['nats']['password']}@#{node['server']['hostname']}:4222"
end

template '/etc/profile.d/ernestenv.sh' do # ~FC033
  source 'ernestenv.sh.erb'
  owner node['server']['user']
  group node['server']['group']
  mode '0755'
  variables(
    env: node['ernest']['environment'],
    nats_uri: nats_uri
  )
end

template '/etc/hosts' do # ~FC033
  source 'hosts.erb'
  action :create
  variables(hostname: hostname, ip: node['server']['ip'], host_ip: node['server']['host_ip'])
end

bash 'disable-firewall' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    ufw disable
    EOH
end

service 'avahi-daemon' do
  action :restart
end

bash 'user' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    apt-get update && apt-get upgrade -y || :
  EOH
end

# Create the ernest user

user 'ernest' do
  action :create
  system true
  manage_home true
  home '/home/ernest'
end
