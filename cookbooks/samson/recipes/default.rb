#
# Cookbook Name:: samson
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
include_recipe "java"
package "ttf-inconsolata"
include_recipe "virtualbox"
package "rabbitmq-server"
include_recipe "riak"
package "socat"
package "mysql-server"
package "p7zip-full"
include_recipe "jce"
package "readpst"
cookbook_file "/etc/default/keyboard" do
  mode "0644"
end
package "xulrunner-2.0"
package "rlwrap"
include_recipe "dropbox"
package "skype"
package "keychain"

package "pidgin"
package "empathy" do
  action :purge
end

remote_file "/tmp/skype4pidgin.deb" do
  source "http://eion.robbmob.com/skype4pidgin.deb"
  not_if "dpkg -s skype4pidgin"
end

dpkg_package "skype4pidgin" do
  source "/tmp/skype4pidgin.deb"
  only_if "test -e /tmp/skype4pidgin.deb"
  not_if "dpkg -s skype4pidgin"
end

package "libnotify-bin"
cookbook_file "/etc/modprobe.d/w510.conf" do
  mode "0644"
end

cookbook_file "/usr/share/X11/xorg.conf.d/50-nvidia.conf" do
  mode "0644"
end
