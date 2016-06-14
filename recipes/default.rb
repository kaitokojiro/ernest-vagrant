# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

include_recipe 'apt'
include_recipe 'ernest-vagrant::system'

include_recipe 'ernest-vagrant::docker'

include_recipe 'ernest-vagrant::postgres'

include_recipe 'golang'
include_recipe 'ernest-vagrant::gnatsd'

include_recipe 'java'

include_recipe 'ernest-vagrant::elk'

include_recipe 'ernest-vagrant::nginx'
include_recipe 'ernest-vagrant::redis'

include_recipe 'ernest-vagrant::ssh'

include_recipe 'ernest-vagrant::ruby'
include_recipe 'ernest-vagrant::jruby'

include_recipe 'ernest-vagrant::basic_gems'

include_recipe 'ernest-vagrant::authentication_middleware'
include_recipe 'ernest-vagrant::myst'
include_recipe 'ernest-vagrant::salt'

include_recipe 'ernest-vagrant::config_store'

include_recipe 'ernest-vagrant::data_microservices'

include_recipe 'ernest-vagrant::vcloud_microservices'

include_recipe 'ernest-vagrant::gpb_microservices'

include_recipe 'ernest-vagrant::ernest'

include_recipe 'ernest-vagrant::user'
