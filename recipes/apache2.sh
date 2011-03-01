# Installs Apache 2 using the Ubuntu packages system.

local apache_dir="/etc/apache2"
local apache_cache_dir="/var/cache/apache2"

restart_apache() {
  run '/usr/sbin/invoke-rc.d apache2 restart'
  run 'sleep 1'
}

reload_apache() {
  run '/usr/sbin/invoke-rc.d apache2 reload'
  run 'sleep 1'
}

# RECIPE
# ----------------------------------------------------------------------------

install_package 'apache2'

# These _should_ exist already, but just to be sure...
create_dir "$apache_dir/ssl"    "u=rwx,go=rx" "root:root"
create_dir "$apache_dir/conf.d" "u=rwx,go=rx" "root:root"
create_dir "$apache_cache_dir"  "u=rwx,go=rx" "root:root"

copy_recipe_files "apache2"
restart_apache
