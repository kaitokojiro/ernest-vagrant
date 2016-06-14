# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'spec_helper'

describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_running }
  it { should be_enabled }
end

describe file('/etc/nginx/sites-enabled/*default') do
  it { should_not be_file }
end

describe file('/etc/nginx/sites-enabled/ernest.local') do
  it { should be_file }
end
