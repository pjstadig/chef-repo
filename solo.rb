CHEF_REPO = File.expand_path(Dir.pwd)
HOSTNAME = `/bin/hostname`.chomp

log_level       :info
log_location    STDOUT
node_name       HOSTNAME
file_cache_path "/tmp/chef-solo"
mkdir_p "/tmp/chef-solo"
json_attribs    "#{CHEF_REPO}/#{HOSTNAME}.json"
cookbook_path   ["#{CHEF_REPO}/cookbooks"]
role_path       "#{CHEF_REPO}/roles"
