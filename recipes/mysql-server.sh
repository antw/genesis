# Installs the MySQL server. Only required on machines where you want to
# store databases, otherwise "mysql-client" will suffice.
#
# The files in recipies/mysql-client are not to be copied using
# copy_recipe_files, but are copied manually.

mysql_restart() {
  say 'Restarting MySQL'
  run 'service mysql restart'
}

# Pre-install setup.
# ----------------------------------------------------------------------------

run_recipe 'mysql-client'

create_dir '/var/cache/local/preseeding' 'u=rwx,go=rx' 'root:root'

# Pre-seed MySQL server settings for unattended package install.

say 'Performing mysql-server pre-install setup'

mysql_preseed_path='/var/cache/local/preseeding/mysql-server.seed'

run "cp '${genesis_path}/recipes/mysql-server/mysql-server.seed' '${mysql_preseed_path}'"
run "chown root:root '${mysql_preseed_path}'"
run "chmod u=rw,go=  '${mysql_preseed_path}'"

run 'debconf-set-selections /var/cache/local/preseeding/mysql-server.seed'

run "cp '${genesis_path}/recipes/mysql-server/debian.cnf' /etc/mysql/debian.cnf"
run 'chown root:root /etc/mysql/debian.cnf'
run 'chmod u=rw,go=  /etc/mysql/debian.cnf'

# Package installation.
# ----------------------------------------------------------------------------

install_package 'mysql-server'

# Post-install setup.
# ----------------------------------------------------------------------------

say 'Copying my.cnf'
run "cp '${genesis_path}/recipes/mysql-server/my.cnf' /etc/mysql/my.cnf"
run 'chown root:root /etc/mysql/my.cnf'
run 'chmod u=rw,go=r /etc/mysql/my.cnf'

mysql_restart

# Set up the grants table.
say 'Copying grants.sql'
run "cp '${genesis_path}/recipes/mysql-server/grants.sql' /etc/mysql/grants.sql"
run 'chown root:root /etc/mysql/grants.sql'
run 'chmod u=rw,go=  /etc/mysql/grants.sql'

run '/usr/bin/mysql -uroot -pchangeme < /etc/mysql/grants.sql'
