#
# Cookbook Name:: samson
# Recipe:: default
#
# Copyright 2012, Paul Stadig
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# add Canonical partner repo
apt_repository "canonical-partner" do
  uri "http://archive.canonical.com/ubuntu"
  distribution node['lsb']['codename']
  components ["partner"]
end

include_recipe "ubuntu"

group "paul" do
  gid 6000
end

user "paul" do
  uid 6000
  gid 6000
  home "/home/paul"
  shell "/bin/bash"
  password "$6$HoaaEPjYjAwHa$Y5jdhVp9obeCH4PKlceyLtLUegNxCkG8ZsOViNanuoiVPdyPQLlvwgPCZh1yF7T1sYulxHp0jk5RBs0mS75a00"
  supports :manage_home => true
end

%w{adm cdrom sudo dip plugdev lpadmin sambashare}.each do |g|
  group g do
    members ["paul"]
    append true
  end
end

package "emacs"
package "rlwrap"
package "openjdk-7-jdk"
package "python-gpgme" # required for dropbox
package "libdbus-ruby" # required for skyyy
package "openvpn"

# setup xmonad
package "xcompmgr"
package "xmonad"
package "libghc-xmonad-dev"
package "libghc-xmonad-contrib-dev"
package "suckless-tools"
package "unclutter"
package "wmctrl"

# setup keys and passwords
package "gnupg-agent"
package "keychain"
gem_package "keybox" do
  version "1.2.1"
end

# setup printing
package "cups-pdf"
package "brother-cups-wrapper-laser"

# install skype
package "lib32stdc++6"
package "lib32asound2"
package "ia32-libs"
package "libc6-i386"
package "lib32gcc1"

directory "/var/cache/tmp"

skype_deb = "skype-ubuntu_2.2.0.35-1_amd64.deb"
remote_file "/var/cache/tmp/#{skype_deb}" do
  action :create_if_missing
  backup false
  source "http://download.skype.com/linux/#{skype_deb}"
  not_if "dpkg -s skype"
end

dpkg_package "skype" do
  source "/var/cache/tmp/#{skype_deb}"
  not_if "dpkg -s skype"
end

# install virtualbox
apt_repository "virtualbox" do
  uri "http://download.virtualbox.org/virtualbox/debian"
  distribution node['lsb']['codename']
  components ["contrib"]
  key "http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc"
  notifies :run, resources(:execute => "apt-get update"), :immediately
end

package "virtualbox-4.1"
oracle_extpack = "Oracle_VM_VirtualBox_Extension_Pack-4.1.14-77440.vbox-extpack"
remote_file "/var/cache/tmp/#{oracle_extpack}" do
  action :create_if_missing
  source "http://dlc.sun.com.edgesuite.net/virtualbox/4.1.14/#{oracle_extpack}"
  not_if 'VBoxManage list extpacks | grep "Oracle VM VirtualBox Extension Pack"'
end

execute "install-extpack" do
  command "VBoxManage extpack install /var/cache/tmp/#{oracle_extpack}"
  not_if 'VBoxManage list extpacks | grep "Oracle VM VirtualBox Extension Pack"'
end

gem_package "vagrant" do
  version "1.0.3"
end

package "gnome-panel"
package "indicator-applet"
package "indicator-applet-session"
package "indicator-applet-appmenu"

package "xfce4-terminal"
execute "update-alternatives --set x-terminal-emulator /usr/bin/xfce4-terminal.wrapper"

directory "/home/ubuntu" do
  action :nothing
  recursive true
  ignore_failure true
end

user "ubuntu" do
  action :remove
  ignore_failure true
  notifies :delete, resources(:directory => "/home/ubuntu"), :immediately
end

group "ubuntu" do
  action :remove
  ignore_failure true
  notifies :delete, resources(:directory => "/home/ubuntu"), :immediately
end
