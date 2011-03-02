# Installs the MySQL server. Only required on machines where you want to
# store databases, otherwise "mysql-client" will suffice.
#
# The files in recipies/mysql-client are not to be copied using
# copy_recipe_files, but are copied manually.

mysql_restart() {
  say 'Restarting MySQL'
  run 'service mysql restart'
}

mysql_root_password="${mysql_root_password:-"changeme"}"
mysql_sys_maint_password="${mysql_root_password:-"changeme"}"
mysql_repl_password="${mysql_repl_password:-"changeme"}"

# Warn about insecure dry runs.
if [[ "${genesis_dry_run:-"0"}" = "1" ]] ; then
  say_error 'SECURITY WARNING: Your MySQL passwords will be stored in'
  say       '  plain-text in the dry-run file. Be sure to keep it safe!'
fi

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

replace_in "${mysql_preseed_path}" 'RootPassword'     "${mysql_root_password}"
replace_in '/etc/mysql/debian.cnf' 'SysMaintPassword' "${mysql_sys_maint_password}"

# Package installation.
# ----------------------------------------------------------------------------

install_package 'mysql-server'

# Post-install setup.
# ----------------------------------------------------------------------------

run "cp '${genesis_path}/recipes/mysql-server/my.cnf' /etc/mysql/my.cnf"
run 'chown root:root /etc/mysql/my.cnf'
run 'chmod u=rw,go=r /etc/mysql/my.cnf'

mysql_restart

# Set up the grants table.
say 'Setting up grants'
run "cp '${genesis_path}/recipes/mysql-server/grants.sql' /etc/mysql/grants.sql"
run 'chown root:root /etc/mysql/grants.sql'
run 'chmod u=rw,go=  /etc/mysql/grants.sql'

# Set passwords in grants.sql
replace_in '/etc/mysql/grants.sql' 'RootPassword'     "${mysql_root_password}"
replace_in '/etc/mysql/grants.sql' 'SysMaintPassword' "${mysql_sys_maint_password}"
replace_in '/etc/mysql/grants.sql' 'ReplPassword'     "${mysql_repl_password}"

run '/usr/bin/mysql -uroot -pchangeme < /etc/mysql/grants.sql'
