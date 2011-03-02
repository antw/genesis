# An example of setting up a MySQL server.

# Set the password we want to use for the MySQL root user, and the
# debian-sys-maint MySQL user. If you don't set these, they will be randomly
# generated; the root user will be able to view them in /etc/mysql/grants.sql

mysql_root_password='my-root-password'
mysql_sys_maint_user='my-debian-sys-maint-password'

# The address to which MySQL should bind. Default is 127.0.0.1.

# This is also customisable on a server-by-server basis. The default, if not
# set, is 256M. A "stock" install of MySQL sets this to only 16M.
mysql_key_buffer='256M'

# There are a number of other settings which can be customised; take a look at
# the lines beginning with a colon (: ) in recipes/mysql-server.sh

# This comes only after we've specified our custom settings above.
run_role 'mysql'
