# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

bash 'jruby' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    wget https://s3.amazonaws.com/jruby.org/downloads/1.7.13/jruby-bin-1.7.13.tar.gz
    tar -xvzf /tmp/jruby-bin-1.7.13.tar.gz
    rm -f jruby-bin-1.7.13.tar.gz
    mv /tmp/jruby-1.7.13/ /usr/local/
    sed -i 's@"$@:/usr/local/jruby-1.7.13/bin"@g'  /etc/environment
    EOH
end
