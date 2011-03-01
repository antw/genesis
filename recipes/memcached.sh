# Installs memcached, listening on localhost:11211 with 64 MB of
# assigned memory.
#
# Customise this on a server-by-server basis by providing an alternative
# memcached.conf file.
#

install_package 'memcached'
install_package 'libmemcache-dev'

copy_recipe_files 'memcached'

run '/etc/init.d/memcached restart'
