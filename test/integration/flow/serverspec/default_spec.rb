# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'spec_helper'

## hosts file
describe host('ernest.local') do
  its(:ipaddress) { should include '10.50.1.11' }
end
