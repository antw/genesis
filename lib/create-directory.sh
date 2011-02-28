# Creates a directory.
#
# $1 -> Path to the directory.
# $2 -> Permissions passed to chmod
# $3 -> user:group passed to chown.
#
create_dir() {
  say_with_time "Creating directory $1"
  mkdir -p $1
  chmod $2 $1
  chown -R $3 $1
}
