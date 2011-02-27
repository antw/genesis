# Install dependencies.

aptitude install -y \
  build-essential libcurl4-openssl-dev zlib1g-dev \
  apache2-prefork-dev libapr1-dev libaprutil1-dev

# Install!

/usr/local/bin/passenger-install-apache2-module --auto
