#
# Cookbook Name:: wintermute
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
# add Canonical partner repo
apt_repository "canonical-partner" do
  uri "http://archive.canonical.com/ubuntu"
  distribution node['lsb']['codename']
  components ["partner"]
end

include_recipe "ubuntu"
include_recipe "paul"
include_recipe "lauren"

package "emacs"
package "rlwrap"
package "openjdk-7-jdk"
package "python-gpgme" # required for dropbox

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

skype_deb = "skype-ubuntu_4.0.0.7-1_amd64.deb"
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

package "gnome-panel"
package "gnome-panel-control"
package "indicator-applet"
package "indicator-applet-session"
package "indicator-applet-appmenu"

package "dconf-tools"

package "fonts-inconsolata"

package "openssh-server"
