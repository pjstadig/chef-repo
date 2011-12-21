#!/bin/bash
echo=/bin/echo
sudo=/usr/bin/sudo
bash=/bin/bash
apt_get=/usr/bin/apt-get
gem=/usr/bin/gem
mkdir=/bin/mkdir
git=/usr/bin/git
chef_solo=/var/lib/gems/1.8/bin/chef-solo

if [ -z `hostname -d` ]; then
    $echo "Please manually configure an FQDN, then re-run this script";
    exit 1;
fi

if [ ! -e /etc/apt/apt.conf.d/99no-install-recommends ]; then
    $sudo $bash -c "$echo 'APT::Install-Recommends \"0\";' > /etc/apt/apt.conf.d/99no-install-recommends"
fi

$sudo $apt_get install -y --no-install-recommends build-essential ruby-full rubygems git emacs
$sudo $gem install --no-rdoc --no-ri chef
$mkdir -p ~/src
cd ~/src
if [ ! -e chef-repo ]; then
    if $git clone git@github.com:pjstadig/chef-repo.git; then
        cd chef-repo
        $sudo $chef_solo -c solo.rb -j `hostname`.json
    fi
else
    cd chef-repo
    $sudo $chef_solo -c solo.rb -j `hostname`.json
fi
