CHEF_REPO = File.expand_path(File.dirname(__FILE__) + "/..")

file_cache_path "#{CHEF_REPO}/.solo"
cookbook_path   "#{CHEF_REPO}/.solo/cookbooks"
role_path       "#{CHEF_REPO}/.solo/roles"
