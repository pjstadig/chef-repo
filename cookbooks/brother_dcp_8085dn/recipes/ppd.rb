#
# Cookbook Name:: brother_dcp_8085dn
# Recipe:: ppd
#
# Copyright 2010, Paul Stadig
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

include_recipe "brother_dcp_8085dn::common"

ppd_file = "BR8085_2_GPL.ppd"
remote_file "#{Chef::Config[:file_cache_path]}/#{ppd_file}.gz" do
  source "http://www.brother.com/pub/bsc/linux/dlf/#{ppd_file}.gz"
  backup false
end

execute "gunzip #{ppd_file}.gz && cp #{ppd_file} /usr/share/ppd/" do
  cwd Chef::Config[:file_cache_path]
  not_if { File.exists?("/usr/share/ppd/#{ppd_file}") }
  notifies :create, "file[/usr/share/ppd/#{ppd_file}]"
end

file "/usr/share/ppd/#{ppd_file}" do
  owner "root"
  group "root"
  mode  "0644"
  notifies :restart, "service[cups]"
end
