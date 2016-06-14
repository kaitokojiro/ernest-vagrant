# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

name 'ernest-vagrant'
maintainer 'R3 Labs'
maintainer_email 'maintainers@r3labs.io'
license 'Copyright 2015-2016 R3Labs'
description 'Ernest Vagrant environment cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
issues_url 'ernest.io'
source_url 'ernest.io'
version '1.0.0'

%w(ubuntu).each do |os|
  supports os
end

depends 'apt'
depends 'golang'
depends 'java'
depends 'nginx'
depends 'apt-docker'
depends 'docker'
