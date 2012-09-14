name "ec2"
description "Role to configure samson."
# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list("recipe[ec2]")
# Attributes applied if the node doesn't have it set already.
#default_attributes()
# Attributes applied no matter what the node has set already.
#override_attributes()
