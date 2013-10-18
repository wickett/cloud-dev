#
# cookbook name:: cloud-dev
# recipe:: default
#
# copyright 2013, james wickett
#
# all rights reserved - do not redistribute
#

# default package
include_recipe 'apt' 

%w{libxml2-dev libxslt-dev curl libcurl4-openssl-dev build-essential exuberant-ctags ack xclip ack-grep}.each do | dev_pkg |
  package dev_pkg do 
    action :install
  end
end

# default dev needs
include_recipe 'ntp' 
include_recipe 'tmux' 

# ruby 
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
  code <<-eoh
    curl https://github.com/wickett.keys 2>/dev/null > /home/ubuntu/.ssh/authorized_keys
    sed -i -e 's@^@command="/usr/bin/tmux -S /tmp/wickett attach -t wickett || /usr/bin/tmux -S /tmp/wickett new -s wickett" @' /home/ubuntu/.ssh/authorized_keys
    eoh
end

bash "get tmux conf" do
  user "ubuntu"
  code <<-eoh
    curl https://gist.github.com/wickett/6394562/raw/.tmux.conf 2>/dev/null > /home/ubuntu/.tmux.conf
    eoh
end

bash "get fonts" do
  user "ubuntu"
  code <<-eoh
    mkdir -p /home/ubuntu/.fonts
    curl https://gist.github.com/qrush/1595572/raw/51bdd743cc1cc551c49457fe1503061b9404183f/inconsolata-dz-powerline.otf 2>/dev/null > /home/ubuntu/.fonts/inconsolata-dz-powerline.otf 
    curl https://gist.github.com/qrush/1595572/raw/417a3fa36e35ca91d6d23ac961071094c26e5fad/menlo-powerline.otf 2>/dev/null > /home/ubuntu/.fonts/menlo-powerline.otf 
    curl https://gist.github.com/qrush/1595572/raw/2eb22321d590265799aac5b166cd19f8358b0db1/mensch-Powerline.otf 2>/dev/null > /home/ubuntu/.fonts/mensch-Powerline.otf
    eoh
end

