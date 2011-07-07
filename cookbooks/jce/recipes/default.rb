#
# Cookbook Name:: jce
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
cookbook_file "/usr/lib/jvm/java-6-sun/jre/lib/security/US_export_policy.jar" do
  mode "0644"
end

cookbook_file "/usr/lib/jvm/java-6-sun/jre/lib/security/local_policy.jar" do
  mode "0644"
end