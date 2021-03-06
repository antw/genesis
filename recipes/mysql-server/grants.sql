# Generated by Genesis.
# Local modifications will be overwritten.

GRANT
  SELECT, INSERT, UPDATE, DELETE, CREATE, DROP,
  RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES,
  INDEX, ALTER, SHOW DATABASES, SUPER,
  CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE,
  REPLICATION SLAVE, REPLICATION CLIENT
ON *.*
TO 'debian-sys-maint'@'localhost'
IDENTIFIED BY '##SysMaintPassword##'
WITH GRANT OPTION;

# Set the server root password. This should be preseeded by the package installation.
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('##RootPassword##');
