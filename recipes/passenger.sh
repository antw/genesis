# Install dependencies.

install_package 'build-essential'
install_package 'libcurl4-openssl-dev'
install_package 'zlib1g-dev'
install_package 'apache2-prefork-dev'
install_package 'libapr1-dev'
install_package 'libaprutil1-dev'

# Install!

/usr/local/bin/passenger-install-apache2-module --auto
