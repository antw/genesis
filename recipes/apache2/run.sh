# Installs Apache 2 using the Ubuntu packages system.

local apache_dir="/etc/apache2"
local apache_log_dir="/var/log/apache2"
local apache_user="www-data"
local apache_binary="/usr/sbin/apache2"
local apache_icon_dir="/usr/share/apache2/icons"
local apache_cache_dir="/var/cache/apache2"

restart_apache() {
  /usr/sbin/invoke-rc.d apache2 restart
  sleep 1
}

reload_apache() {
  /usr/sbin/invoke-rc.d apache2 reload
  sleep 1
}

# RECIPE
# ----------------------------------------------------------------------------

aptitude install apache2

# Create Apache directories.
genesis_create_dir "$apache_dir/ssl"    "u=rwx,go=rx" "root:root"
genesis_create_dir "$apache_dir/conf.d" "u=rwx,go=rx" "root:root"
genesis_create_dir "$apache_cache_dir"  "u=rwx,go=rx" "root:root"
