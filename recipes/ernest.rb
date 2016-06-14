# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

rack_env = 'production'
rack_env = 'test' if node['ernest']['environment'] == 'test'
rack_env = 'development' if node['ernest']['environment'] == 'dev'

node['ernest']['services']['data'].each do |microservice|
  template "/lib/systemd/system/#{microservice}.service" do # ~FC033
    source 'data-microservice.service.erb'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
    variables(
      lazy do
        {
          organization: node['ernest']['organization'],
          name: microservice,
          user: node['server']['user'],
          env: node['ernest']['environment'],
          rackenv: rack_env,
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

node['ernest']['services']['vcloud'].each do |microservice|
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

node['ernest']['services']['gpb'].each do |microservice|
  next if ['vcloud-fakery'].include? microservice

  template "/lib/systemd/system/#{microservice}.service" do # ~FC033
    source 'gpb-microservice.service.erb'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
    variables(
      lazy do
        {
          organization: node['ernest']['organization'],
          name: microservice,
          user: node['server']['user'],
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

template '/usr/local/bin/ernestctl' do # ~FC033
  source 'ernestctl.erb'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  variables(
    gpb: node['ernest']['services']['gpb'],
    data: node['ernest']['services']['data'],
    vcloud: node['ernest']['services']['vcloud']
  )
end
