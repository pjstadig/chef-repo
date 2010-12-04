#
# Cookbook Name:: brother_dcp_8085dn
# Recipe:: default
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
include_recipe "brother_dcp_8085dn::ppd"

package "ia32-libs"

execute "ln -s /etc/init.d/cups /etc/init.d/lpd" do
  not_if { File.exists?("/etc/init.d/lpd") }
end

cache_dir = Chef::FileCache.create_path([Chef::Config[:file_cache_path], "brother_dcp_8085dn"])
remote_file "#{cache_dir}/lpr.deb" do
  source "http://www.brother.com/pub/bsc/linux/dlf/dcp8085dnlpr-2.0.3-1.i386.deb"
end

remote_file "#{cache_dir}/cupswrapper.deb" do
  source "http://www.brother.com/pub/bsc/linux/dlf/cupswrapperDCP8085DN-2.0.4-1.i386.deb"
end

execute "dpkg -i --force-all #{cache_dir}/lpr.deb && dpkg -i --force-all #{cache_dir}/cupswrapper.deb" do
  not_if "dpkg  -l | grep  Brother"
end

execute "/etc/init.d/cups restart"
