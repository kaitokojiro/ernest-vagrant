# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

jruby = 'JRUBY_OPTS="--1.9 -Xcext.enabled=true" /usr/local/jruby-1.7.13/bin/jruby -S'

bash 'install-bundler' do
  user 'root'
  code <<-EOH
    #{jruby} gem install bundle
    gem install bundle
  EOH
end
