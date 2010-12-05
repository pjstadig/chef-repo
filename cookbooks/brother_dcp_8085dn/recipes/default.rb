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

if node.platform == "ubuntu" && node.platform_version == "10.10"
  execute "cp /etc/init/cups.conf /etc/init/lpd.conf" do
    not_if { File.exists?("/etc/init/lpd.conf") }
  end
end

link "/etc/init.d/lpd" do
  to "/etc/init.d/cups"
end

lpr_deb = "dcp8085dnlpr-2.0.3-1.i386.deb"
lpr_deb_path = "#{Chef::Config[:file_cache_path]}/#{lpr_deb}"
remote_file lpr_deb_path do
  source "http://www.brother.com/pub/bsc/linux/dlf/#{lpr_deb}"
  backup false
end

cups_deb = "cupswrapperDCP8085DN-2.0.4-1.i386.deb"
cups_deb_path = "#{Chef::Config[:file_cache_path]}/#{cups_deb}"
remote_file cups_deb_path do
  source "http://www.brother.com/pub/bsc/linux/dlf/#{cups_deb}"
  backup false
end

dpkg_package "brother-8085dn-lpr" do
  source lpr_deb_path
  options "--force-all"
  notifies :restart, "service[cups]"
end

dpkg_package "brother-8085dn-cups-wrapper" do
  source cups_deb_path
  options "--force-all"
  notifies :restart, "service[cups]"
end
