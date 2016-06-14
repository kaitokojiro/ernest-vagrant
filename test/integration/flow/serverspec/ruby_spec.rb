# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'spec_helper'

describe 'ruby' do
  describe command 'ruby -v' do
    its(:stdout) { should include 'ruby 2.2.2p95' }
  end

  describe command 'cat /etc/gemrc' do
    its(:stdout) { should include 'gem: --no-document' }
  end
end
