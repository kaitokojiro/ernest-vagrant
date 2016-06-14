# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

bash 'ruby' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    if [ $(ruby -e "print RUBY_VERSION") == "2.2.2" ]; then
      echo "Ruby already installed. Skipping"
    else
      rm -rf ruby-2.2.2.tar.gz
      wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz
      tar xvzmf ruby-2.2.2.tar.gz
      cd ruby-2.2.2
      ./configure
      make
      make install
    fi
    EOH
end

bash 'Configure gem to not install rdoc' do
  user 'root'
  group 'root'
  code 'echo "gem: --no-document" >> /etc/gemrc'
end
