#
# Cookbook Name:: brother_dcp_8085dn
# Recipe:: common
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

package "cups"
execute "aa-complain cupsd"
execute "mkdir /usr/share/cups/model" do
  not_if { File.exists?("/usr/share/cups/model") }
end

