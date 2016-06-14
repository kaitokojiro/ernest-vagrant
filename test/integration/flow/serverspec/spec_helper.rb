# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'serverspec'
require 'pathname'
require 'infrataster/rspec'

set :backend, :Exec

# include Serverspec::Helper::Exec
# include Serverspec::Helper::DetectOS
Infrataster::Server.define(:app, '127.0.0.1')
