maintainer       "Paul Stadig"
maintainer_email "paul@stadig.name"
license          "Apache 2.0"
description      "Installs/Configures samson"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"
%w{java virtualbox riak}.each do |d|
  depends d
end
supports         "ubuntu"
