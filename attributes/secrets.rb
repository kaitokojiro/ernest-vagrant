# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

default['secrets'] = {
  'postgres' => {
    'root_user' => 'root',
    'root_password' => 'w4rmR3d',
    'user' => 'mr_foo',
    'password' => 'mr_foo'
  },
  'ernest' => {
    'admin_email' => 'admin@r3labs.io',
    'admin_username' => 'admin',
    'admin_password' => 'w4rmR3d',
    'admin_salt' => 's4lt',
    'client_name' => 'admin'
  },
  'nats' => {
    'username' => 'ernest',
    'password' => 'Novpyw59'
  },
  'redis' => {
    'password' => 'Okv8kWF5_x'
  },
  'salt' => {
    'user' => 'salt',
    'password' => '33Arma33'
  },
  'jwt_token' => 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ'
}
