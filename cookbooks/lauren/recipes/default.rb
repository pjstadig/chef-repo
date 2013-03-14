#
# Cookbook Name:: lauren
# Recipe:: default
#
# Copyright 2013, Paul Stadig
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
group "lauren" do
  gid 6001
end

user "lauren" do
  uid 6001
  gid 6001
  home "/home/lauren"
  shell "/bin/bash"
  password "$6$HoaaEPjYjAwHa$Y5jdhVp9obeCH4PKlceyLtLUegNxCkG8ZsOViNanuoiVPdyPQLlvwgPCZh1yF7T1sYulxHp0jk5RBs0mS75a00"
  supports :manage_home => true
  not_if "getent passwd lauren"
end

%w{adm cdrom sudo dip plugdev lpadmin sambashare}.each do |g|
  group g do
    members ["lauren"]
    append true
  end
end

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
