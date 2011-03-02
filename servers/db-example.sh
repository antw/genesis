# An example of setting up a MySQL server.

# Set the password we want to use for the MySQL root user, and the
# debian-sys-maint MySQL user. If you don't set these, they will be
# randomly generated; the root user will be able to view them in
# /etc/mysql/grants.sql

mysql_root_password='my-root-password'
mysql_sys_maint_user='my-debian-sys-maint-password'

# Running the mysql-server recipe also installs the client.

run_role 'mysql'
