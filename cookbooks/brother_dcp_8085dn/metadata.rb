maintainer       "Paul Stadig"
maintainer_email "paul@stadig.name"
license          "Apache 2.0"
description      "Installs/Configures printer drivers for the Brother DCP-8085DN"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"
depends          "apt"
supports         "ubuntu"
recipe("brother_dcp_8085dn",
       "Installs Brother DCP-8085DN print driver")
