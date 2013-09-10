#
# Cookbook Name:: cloud-dev
# Recipe:: default
#
# Copyright 2013, James Wickett
#
# All rights reserved - Do Not Redistribute

package "build-essential" do
  action :install
end
package "curl" do
  action :install
end
package "libcurl4-openssl-dev" do
  action :install
end
package "exuberant-ctags" do
  action :install
end
package "ack" do
  action :install
end

# Default dev needs
include_recipe 'ntp' 
include_recipe 'tmux' 

# Ruby 
node.override['rvm']['rvm_gem_options'] = "--rdoc --ri"
node.override['rvm']['user_installs'] = [
    { 'user' => 'ubuntu',
      'version' => '1.9.3',
      'default_ruby' => 'ruby'
    }
]
include_recipe 'rvm::user_install' 

bash "get gitub pub keys" do 
  user "ubuntu"
  code <<-EOH
    curl https://github.com/wickett.keys 2>/dev/null > /home/ubuntu/.ssh/authorized_keys
    sed -i -e 's@^@command="/usr/bin/tmux -S /tmp/wickett attach -t wickett || /usr/bin/tmux -S /tmp/wickett new -s wickett" @' /home/ubuntu/.ssh/authorized_keys
    EOH
end

bash "get tmux conf" do
  user "ubuntu"
  code <<-EOH
    curl https://gist.github.com/wickett/6394562/raw/.tmux.conf 2>/dev/null > /home/ubuntu/.tmux.conf
    EOH
end
