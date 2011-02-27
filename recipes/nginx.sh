# Recipe to install nginx from the Ubuntu Personal Package Archive, since it's
# much more up-to-date than the normal package.
#
# Use this recipe only if you want nginx without passenger, otherwise use the
# passenger-nginx recipe.

if [ ! -f /etc/apt/sources.list.d/nginx-stable-lucid.list ] ; then
  # Required for add-apt-repository.
  aptitude \
    -o Aptitude::Cmdline::ignore-trust-violations=true install \
    -y python-software-properties

  add-apt-repository "ppa:nginx/stable"

  apt-get update

  # Clean up.
  aptitude remove python-software-properties unattended-upgrades
fi

apt-get install -y nginx
