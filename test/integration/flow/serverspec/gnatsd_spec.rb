# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'spec_helper'

describe 'gnatsd' do
  describe 'gnatsd is installed' do
    describe command 'ls -l /opt/gnatsd/' do
      its(:stdout) { should include 'gnatsd' }
    end
  end
  describe 'gnatsd is running' do
    describe service('gnatsd') do
      it { should be_running }
      it { should be_enabled }
    end
  end
  describe 'gnatsd is listening on port 4222' do
    describe port(4222) do
      it { should be_listening }
    end
  end
end
