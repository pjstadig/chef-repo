#
# Cookbook Name:: pairing
# Recipe:: default
#
# Copyright 2011, Paul Stadig.
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
%w{emacs tmux socat p7zip-full readpst rlwrap curl git-core}.each do |p|
  package p
end
include_recipe "java"
include_recipe "jce"

# TODO: setup lotus
# TODO: install 32-bit JVM?
# TODO: setup oit
# TODO: create user
# TODO: create home dir
# TODO: checkout dotfiles?
