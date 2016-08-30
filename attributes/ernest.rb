# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

default['ernest']['organization'] = 'ErnestIO'
default['ernest']['version'] = 'develop'
default['ernest']['versions'] = {}
default['ernest']['library-versions'] = {}

default['ernest']['libraries']['path'] = '/opt/ernest-libraries'

default['ernest']['libraries']['myst']['folder'] = 'myst'
default['ernest']['libraries']['myst']['repo'] = "git@github.com:#{node['ernest']['organization']}/myst.git"
default['ernest']['libraries']['myst']['path'] = '/opt/ernest-libraries/myst'
default['ernest']['libraries']['myst']['vcloud_provider']['folder'] = 'lib/myst/providers/vcloud'

default['ernest']['environment'] = 'dev'

default['ernest']['environments'] = %w(dev test staging)

default['ernest']['application']['repos'] = {}

default['ernest']['application']['service_url']   = "http://#{node['server']['hostname']}"
default['ernest']['application']['client_id']     = 1
default['ernest']['application']['user_id']       = 1
default['ernest']['application']['client_name']   = node['secrets']['ernest']['client_name']
default['ernest']['application']['user_name']     = node['secrets']['ernest']['admin_username']
default['ernest']['application']['user_email']    = node['secrets']['ernest']['admin_email']
default['ernest']['application']['user_password'] = node['secrets']['ernest']['admin_password']
default['ernest']['application']['user_salt']     = node['secrets']['ernest']['admin_salt']

default['ernest']['services']['gpb'] = {
  'nat-builder' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'firewall-builder' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'instance-builder' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'network-builder' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'router-builder' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'execution-builder' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'workflow-manager' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'definition-mapper' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'router-adapter' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'nat-adapter' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'network-adapter' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'instance-adapter' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'firewall-adapter' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'execution-adapter' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'all-all-fake-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'monit' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'logger' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'group-store' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'user-store' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'datacenter-store' =>  { org: 'ErnestIO', version: node['ernest']['version'] },
  'service-store' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'api-gateway' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'vcloud-definition-mapper' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'aws-definition-mapper' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'network-creator-aws-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'network-deleter-aws-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'firewall-creator-aws-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'firewall-updater-aws-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'firewall-deleter-aws-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'nat-creator-aws-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'nat-deleter-aws-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'instance-creator-aws-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'instance-updater-aws-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'instance-deleter-aws-connector' => { org: 'ErnestIO', version: node['ernest']['version'] }
}

default['ernest']['services']['vcloud'] = {
  'firewall-creator-vcloud-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'instance-creator-vcloud-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'instance-updater-vcloud-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'execution-run-salt-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'nat-creator-vcloud-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'network-creator-vcloud-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'router-creator-vcloud-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'instance-deleter-vcloud-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'firewall-updater-vcloud-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'nat-updater-vcloud-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'router-deleter-vcloud-connector' => { org: 'ErnestIO', version: node['ernest']['version'] },
  'network-deleter-vcloud-connector' => { org: 'ErnestIO', version: node['ernest']['version'] }
}

default['ernest']['services']['all'] = default['ernest']['services']['gpb'].merge(default['ernest']['services']['vcloud'])

default['ernest']['connectors']['routers'] = %w(fake vcloud vcloud-fake aws aws-fake)
default['ernest']['connectors']['networks'] = %w(fake vcloud vcloud-fake aws aws-fake)
default['ernest']['connectors']['instances'] = %w(fake vcloud vcloud-fake aws aws-fake)
default['ernest']['connectors']['firewalls'] = %w(fake vcloud vcloud-fake aws aws-fake)
default['ernest']['connectors']['nats'] = %w(fake vcloud vcloud-fake aws aws-fake)
default['ernest']['connectors']['executions'] = %w(fake salt)
