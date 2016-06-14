# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

home = "/home/#{node['server']['user']}"
user = node['server']['user']
group = node['server']['group']

bash 'user' do
  user 'root'
  cwd home
  code <<-EOH
    cd /tmp
    rm -rf sexy-bash-prompt
    git clone --depth 1 https://github.com/twolfson/sexy-bash-prompt
    cd sexy-bash-prompt
    make install
    source ~/.bashrc
    cp ~/.bashrc #{home}/.bashrc
    cp ~/.bash_prompt #{home}/.bash_prompt
    chown #{user}:#{group} #{home}/.bash_prompt
    chown #{user}:#{group} #{home}/.bashrc
  EOH
end
