# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

node['ernest']['services']['vcloud'].each do |microservice, _attrs|
  template "/lib/systemd/system/#{microservice}.service" do # ~FC033
    source 'vcloud-microservice.service.erb'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
    variables(
      lazy do
        {
          name: microservice,
          user: node['server']['user'],
          gopath: '/opt/go',
          jrubypath: '/usr/local/jruby-1.7.13/bin/',
          natsuri: node['nats']['url']
        }
      end
    )
  end

  service microservice do
    supports [:start, :stop, :restart]
    action [:enable, :start]
  end
end

stores = ['group-store', 'user-store', 'datacenter-store', 'service-store']

node['ernest']['services']['gpb'].each do |microservice, attrs|
  next if ['vcloud-fakery'].include? microservice

  template "/lib/systemd/system/#{microservice}.service" do # ~FC033
    if stores.include? microservice
      source 'store-microservice.service.erb'
    else
      source 'gpb-microservice.service.erb'
    end
    owner 'root'
    group 'root'
    mode '0644'
    action :create
    variables(
      lazy do
        {
          organization: attrs[:org],
          name: microservice,
          user: node['server']['user'],
          natsuri: node['nats']['url'],
          logfile: node['ernest']['logfile'],
          connectors: node['ernest']['connectors_list']
        }
      end
    )
  end

  service microservice do
    supports [:start, :stop, :restart]
    action [:enable, :start]
  end
end

template '/usr/local/bin/ernestctl' do # ~FC033
  source 'ernestctl.erb'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  variables(
    gpb: node['ernest']['services']['gpb'],
    vcloud: node['ernest']['services']['vcloud']
  )
end
