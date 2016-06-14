# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

default['ernest']['organization'] = 'ernestio'
default['ernest']['version'] = 'develop'
default['ernest']['versions'] = {}
default['ernest']['library-versions'] = {}

default['ernest']['libraries']['path'] = '/opt/ernest-libraries'

default['ernest']['libraries']['myst']['folder'] = 'myst'
default['ernest']['libraries']['myst']['repo'] = 'git@github.com:ernestio/myst.git'
default['ernest']['libraries']['myst']['path'] = '/opt/ernest-libraries/myst'
default['ernest']['libraries']['myst']['vcloud_provider']['folder'] = 'lib/myst/providers/vcloud'

default['ernest']['environment'] = 'dev'

default['ernest']['environments'] = %w(dev test staging)

default['ernest']['application']['service_url']   = "http://#{node['server']['hostname']}"
default['ernest']['application']['client_id']     = SecureRandom.uuid
default['ernest']['application']['user_id']       = SecureRandom.uuid
default['ernest']['application']['client_name']   = node['secrets']['ernest']['client_name']
default['ernest']['application']['user_name']     = node['secrets']['ernest']['admin_username']
default['ernest']['application']['user_email']    = node['secrets']['ernest']['admin_email']
default['ernest']['application']['user_password'] = node['secrets']['ernest']['admin_password']
default['ernest']['application']['user_salt']     = node['secrets']['ernest']['admin_salt']

default['ernest']['services']['gpb'] = ['nat-builder', 'firewall-builder',
                                        'instance-builder', 'network-builder',
                                        'router-builder', 'execution-builder',
                                        'workflow-manager', 'definition-mapper',
                                        'router-adapter', 'nat-adapter', 'network-adapter', 'instance-adapter',
                                        'firewall-adapter', 'execution-adapter', 'all-all-fake-connector',
                                        'monit', 'logger']

default['ernest']['services']['vcloud'] = ['firewall-creator-vcloud-connector', 'instance-creator-vcloud-connector',
                                           'instance-updater-vcloud-connector', 'execution-run-salt-connector',
                                           'nat-creator-vcloud-connector', 'network-creator-vcloud-connector',
                                           'router-creator-vcloud-connector', 'instance-deleter-vcloud-connector',
                                           'firewall-updater-vcloud-connector', 'nat-updater-vcloud-connector',
                                           'router-deleter-vcloud-connector', 'network-deleter-vcloud-connector']

default['ernest']['services']['data'] = ['user-store', 'service-store',
                                         'datacenter-store', 'client-store']

default['ernest']['services']['all'] = default['ernest']['services']['gpb'] +
                                       default['ernest']['services']['vcloud'] +
                                       default['ernest']['services']['data']

default['ernest']['connectors']['routers'] = %w(fake vcloud)
default['ernest']['connectors']['networks'] = %w(fake vcloud)
default['ernest']['connectors']['instances'] = %w(fake vcloud)
default['ernest']['connectors']['firewalls'] = %w(fake vcloud)
default['ernest']['connectors']['nats'] = %w(fake vcloud)
default['ernest']['connectors']['executions'] = %w(fake salt)
