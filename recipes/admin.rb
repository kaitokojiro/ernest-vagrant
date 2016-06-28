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
      Chef::Log.info("Admin user added")
      NATS.publish('user.set', {"group_id" => 1, "username" => "admin", "password" => node['ernest']['application']['user_password'], "admin" => true}.to_json)
    end

    def add_group
      Chef::Log.info("Admin group added")
      NATS.publish('group.set', '{"name": "admin"}')
    end

    NATS.on_error { |err| puts "Server Error: #{err}" }

    NATS.start(:uri => node['nats']['url'], :autostart => true) do
      gf = NATS.request('group.find') do |msg|
        @ready << :group
        add_group unless msg.include? "admin"
        NATS.stop if @ready.include?(:user) && @ready.include?(:group)
      end
      NATS.timeout(gf, 5, :expected => 1) { Chef::Log.info("Group store not ready") }

      uf = NATS.request('user.find') do |msg|
        @ready << :user
        add_user unless msg.include? "admin"
        NATS.stop if @ready.include?(:user) && @ready.include?(:group)
      end
      NATS.timeout(uf, 5, :expected => 1) { Chef::Log.info("User store not ready") }

      rs = NATS.subscribe('register') do |msg|
        @ready << :group; add_group if msg.include? 'group-store'
        @ready << :user; add_user if msg.include? 'user-store'
        NATS.stop if @ready.include?(:user) && @ready.include?(:group)
      end

      NATS.timeout(rs, 120) { Chef::Application.fatal!("Could not register admin user and group") }
    end

  end
  action :run
end
