name "sun_java"
description "Installs Sun Java."
run_list("recipe[java]")
override_attributes("java" => {"install_flavor" => "sun"})
