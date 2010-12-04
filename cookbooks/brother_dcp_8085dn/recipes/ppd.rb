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

cache_dir = Chef::FileCache.create_path([Chef::Config[:file_cache_path], "brother_dcp_8085dn"])
remote_file "#{cache_dir}/BR8085_2_GPL.ppd.gz" do
  source "http://www.brother.com/pub/bsc/linux/dlf/BR8085_2_GPL.ppd.gz"
end

execute "gunzip BR8085_2_GPL.ppd.gz" do
  cwd cache_dir
  not_if { File.exists?("#{cache_dir}/BR8085_2_GPL.ppd") }
end

execute "cp #{cache_dir}/BR8085_2_GPL.ppd /usr/share/cups/model && chmod 644 /usr/share/cups/model/BR8085_2_GPL.ppd && chown root:root /usr/share/cups/model/BR8085_2_GPL.ppp" do
  not_if { File.exists?("/usr/share/cups/model/BR8085_2_GPL.ppd") }
end

execute "/etc/init.d/cups restart"
