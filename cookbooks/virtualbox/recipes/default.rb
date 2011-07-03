#
# Cookbook Name:: virtualbox
# Recipe:: default
#
# Copyright 2011, Paul Stadig
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
execute "wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -" do
  not_if "sudo apt-key finger | grep \"7B0F AB3A 13B9 0743 5925  D9C9 5442 2A4B 98AB 5139\""
end

cookbook_file "/etc/apt/sources.list.d/virtualbox.list" do
  mode "0644"
  notifies :run, "execute[apt-get update]", :immediately
end

%w{virtualbox-4.0 dkms}.each do |p|
  package p
end

remote_file "/tmp/Oracle_VM_VirtualBox_Extension_Pack-4.0.10-72436.vbox-extpack" do
  source "http://download.virtualbox.org/virtualbox/4.0.10/Oracle_VM_VirtualBox_Extension_Pack-4.0.10-72436.vbox-extpack"
  not_if "VBoxManage list extpacks | grep \"Oracle VM VirtualBox Extension Pack\""
  notifies :run, "execute[install-extpack]", :immediately
end

execute "install-extpack" do
  command "VBoxManage extpack install /tmp/Oracle_VM_VirtualBox_Extension_Pack-4.0.10-72436.vbox-extpack"
  action :nothing
end
