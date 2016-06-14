# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'spec_helper'

describe 'ssh keys' do
  describe command 'cat ~/.ssh/id_rsa' do
    its(:stdout) { should include 'MIIEogIBAAKCAQEA4Ykrrya7JyjMe' }
  end

  describe command 'ls -l /home/vagrant/.ssh/id_rsa' do
    its(:stdout) { should include '-r--------' }
  end
end
