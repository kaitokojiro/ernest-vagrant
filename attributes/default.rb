# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

include_attribute 'ernest-vagrant::secrets'
include_attribute 'ernest-vagrant::server'
include_attribute 'ernest-vagrant::nginx'
include_attribute 'ernest-vagrant::postgres'
include_attribute 'ernest-vagrant::go'
include_attribute 'ernest-vagrant::nats'
include_attribute 'ernest-vagrant::redis'
include_attribute 'ernest-vagrant::ernest'
include_attribute 'ernest-vagrant::logstash'
include_attribute 'ernest-vagrant::kibana'
