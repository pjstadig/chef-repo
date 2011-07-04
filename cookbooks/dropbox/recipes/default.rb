#
# Cookbook Name:: dropbox
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
execute "apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E" do
  not_if "sudo apt-key finger | grep \"1C61 A265 6FB5 7B7E 4DE0  F4C1 FC91 8B33 5044 912E\""
end

cookbook_file "/etc/apt/sources.list.d/dropbox.list" do
  mode "0644"
  notifies :run, "execute[apt-get update]", :immediately
end

package "nautilus-dropbox"
