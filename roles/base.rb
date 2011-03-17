name "base"
description "Base role applied to all nodes."
# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list("recipe[ohai]", "recipe[chef::client]")
# Attributes applied if the node doesn't have it set already.
#default_attributes()
# Attributes applied no matter what the node has set already.
#override_attributes("chef" => {"server_url" => "https://api.opscode.com/organizations/stadig"})
