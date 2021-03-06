# Recipe to install nginx from the Ubuntu Personal Package Archive, since it's
# much more up-to-date than the normal package.
#
# Use this recipe only if you want nginx without passenger, otherwise use the
# passenger-nginx recipe.

if [ ! -f /etc/apt/sources.list.d/nginx-stable-lucid.list ] ; then
  # Required for add-apt-repository.
  run 'aptitude \
    -o Aptitude::Cmdline::ignore-trust-violations=true install \
    -y python-software-properties'

  run 'add-apt-repository "ppa:nginx/stable"'
  run 'apt-get update'

  # Clean up.
  run 'aptitude remove python-software-properties unattended-upgrades'
fi

install_package 'nginx'
