# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

chef_gem 'nats'

ruby_block 'create group and user' do
  block do
    require 'json'
    require 'nats/client'

    @ready = []

    def add_user
      Chef::Log.info('Admin user added')

      user = {
        'group_id' => 1,
        'username' => 'admin',
        'password' => node['ernest']['application']['user_password'],
        'admin' => true
      }

      NATS.request('user.set', user.to_json) do |msg|
        Chef::Log.info(msg)
        @ready << :user
        shutdown
      end
    end

    def add_group
      Chef::Log.info('Admin group added')

      NATS.request('group.set', '{"name": "admin"}') do |msg|
        Chef::Log.info(msg)
        @ready << :group
        shutdown
      end
    end

    def shutdown
      NATS.flush
      sleep 1
      NATS.stop if @ready.include?(:user) && @ready.include?(:group)
    end

    NATS.on_error { |err| puts "Server Error: #{err}" }

    NATS.start(uri: node['nats']['url'], autostart: true) do
      gf = NATS.request('group.find') { |msg| add_group unless msg.include? 'admin' }
      NATS.timeout(gf, 5, expected: 1) { Chef::Log.info('Group store not ready') }

      uf = NATS.request('user.find') { |msg| add_user unless msg.include? 'admin' }
      NATS.timeout(uf, 5, expected: 1) { Chef::Log.info('User store not ready') }

      rs = NATS.subscribe('register') do |msg|
        add_group if msg.include? 'group-store'
        add_user if msg.include? 'user-store'
      end

      NATS.timeout(rs, 120) { Chef::Application.fatal!('Could not register admin user and group') }
    end
  end
  action :run
end
