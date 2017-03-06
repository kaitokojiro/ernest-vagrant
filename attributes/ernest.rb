# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

default['ernest']['organization'] = 'ernestio'
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
default['ernest']['logfile'] = '/var/log/ernest.log'
default['ernest']['crypto_key'] = 'mMYlPIvI11z20H1BnBmB223355667788'

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
  'scheduler' => { org: 'ernestio', version: node['ernest']['version'] },
  'definition-mapper' => { org: 'ernestio', version: node['ernest']['version'] },
  'all-all-fake-connector' => { org: 'ernestio', version: node['ernest']['version'] },
  'monit' => { org: 'ernestio', version: node['ernest']['version'] },
  'logger' => { org: 'ernestio', version: node['ernest']['version'] },
  'group-store' => { org: 'ernestio', version: node['ernest']['version'] },
  'user-store' => { org: 'ernestio', version: node['ernest']['version'] },
  'datacenter-store' =>  { org: 'ernestio', version: node['ernest']['version'] },
  'service-store' => { org: 'ernestio', version: node['ernest']['version'] },
  'api-gateway' => { org: 'ernestio', version: node['ernest']['version'] },
  'all-all-aws-connector' => { org: 'ernestio', version: node['ernest']['version'] }
}

default['ernest']['services']['vcloud'] = {
  'firewall-creator-vcloud-connector' => { org: 'ernestio', version: node['ernest']['version'] },
  'instance-creator-vcloud-connector' => { org: 'ernestio', version: node['ernest']['version'] },
  'instance-updater-vcloud-connector' => { org: 'ernestio', version: node['ernest']['version'] },
  'execution-run-salt-connector' => { org: 'ernestio', version: node['ernest']['version'] },
  'nat-creator-vcloud-connector' => { org: 'ernestio', version: node['ernest']['version'] },
  'network-creator-vcloud-connector' => { org: 'ernestio', version: node['ernest']['version'] },
  'router-creator-vcloud-connector' => { org: 'ernestio', version: node['ernest']['version'] },
  'instance-deleter-vcloud-connector' => { org: 'ernestio', version: node['ernest']['version'] },
  'firewall-updater-vcloud-connector' => { org: 'ernestio', version: node['ernest']['version'] },
  'nat-updater-vcloud-connector' => { org: 'ernestio', version: node['ernest']['version'] },
  'router-deleter-vcloud-connector' => { org: 'ernestio', version: node['ernest']['version'] },
  'network-deleter-vcloud-connector' => { org: 'ernestio', version: node['ernest']['version'] }
}

default['ernest']['services']['all'] = default['ernest']['services']['gpb'].merge(default['ernest']['services']['vcloud'])

default['ernest']['connectors']['routers'] = %w(fake vcloud vcloud-fake aws aws-fake)
default['ernest']['connectors']['networks'] = %w(fake vcloud vcloud-fake aws aws-fake)
default['ernest']['connectors']['instances'] = %w(fake vcloud vcloud-fake aws aws-fake)
default['ernest']['connectors']['firewalls'] = %w(fake vcloud vcloud-fake aws aws-fake)
default['ernest']['connectors']['nats'] = %w(fake vcloud vcloud-fake aws aws-fake)
default['ernest']['connectors']['executions'] = %w(fake salt)
default['ernest']['connectors']['elbs'] = %w(fake aws aws-fake)
default['ernest']['connectors_list'] = 'nat.create.aws,nat.update.aws,nat.delete.aws,network.create.aws,network.delete.aws,route53.create.aws,route53.delete.aws,route53.update.aws,s3.create.aws,s3.update.aws,s3.delete.aws,elb.create.aws,elb.delete.aws,elb.update.aws,vpc.create.aws,vpc.delete.aws,instance.delete.aws,instance.update.aws,instance.create.aws,firewall.create.aws,firewall.update.aws,firewall.delete.aws,ebs.create.aws,ebs.update.aws,ebs.delete.aws,nats.find.aws,networks.find.aws,route53s.find.aws,s3s.find.aws,elbs.find.aws,vpcs.find.aws,instances.find.aws,firewalls.find.aws,ebs_volumes.find.aws,rds_clusters.find.aws,rds_instances.find.aws'
