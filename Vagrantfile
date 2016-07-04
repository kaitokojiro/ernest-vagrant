# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'.freeze
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'ubuntu/wily64'
  # config.vm.box = 'flow-basebox'
  # config.vm.box_url = 'http://artefact.r3labs.io/boxes/flow-basebox-1.3.0.box'

  config.vm.hostname = 'ernest.local'
  config.vm.network 'private_network', ip: '10.50.1.11'

  config.vm.provider 'virtualbox' do |v|
    v.memory = 4096
    # v.cpus = 2
    # Allow the vagrant guest to resolve connections using the host's VPN
    # connection, so can resolve internal.vpn domains
    v.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    v.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
  end

  config.vm.provision 'chef_solo' do |chef|
    # chef.log_level = :debug
    chef.add_recipe 'ernest-vagrant'
    #  chef.json = {
    #    "ernest" => {
    #      "version" => "develop",
    #      "versions" => {
    #        "workflow-manager" => "branch-name",
    #      }
    #      "application" => {
    #        "repos" => {
    #           "workflow-manager" => "git@github.com:org/repo-name.git"
    #        }
    #      }
    #    }
    #  }
  end
end
