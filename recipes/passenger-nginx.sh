# Install dependencies.

aptitude install -y build-essential libcurl4-openssl-dev zlib1g-dev

# Install!

/usr/local/bin/passenger-install-nginx-module \
  --auto \
  --auto-download \
  --prefix=/usr/local
