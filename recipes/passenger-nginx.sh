# Install dependencies.

install_package 'build-essential'
install_package 'libcurl4-openssl-dev'
install_package 'zlib1g-dev'

# Install!

/usr/local/bin/passenger-install-nginx-module \
  --auto \
  --auto-download \
  --prefix=/usr/local
