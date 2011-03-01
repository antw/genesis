# Creates a directory.
#
# $1 -> Path to the directory.
# $2 -> Permissions passed to chmod
# $3 -> user:group passed to chown.
#
create_dir() {
  say "Creating directory $1"
  run "mkdir -p $1"
  run "chmod $2 $1"
  run "chown -R $3 $1"
}
