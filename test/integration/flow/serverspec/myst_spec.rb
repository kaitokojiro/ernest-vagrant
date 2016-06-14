# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'spec_helper'

describe 'myst' do
  describe 'myst gem installed on jruby' do
    describe command 'ls -l /opt/flow-libraries/' do
      its(:stdout) { should include 'myst' }
    end
  end

  describe 'VCloud provider is in place' do
    describe command 'ls -l /opt/flow-libraries/myst/lib/myst/providers/vcloud/' do
      its(:stdout) { should include 'VMware-vCloudDirector-JavaSDK' }
    end
  end
end
