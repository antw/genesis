# Creates a directory.
#
# $1 -> Path to the directory.
# $2 -> Permissions passed to chmod
# $3 -> user:group passed to chown.
#
genesis_create_dir() {
  mkdir -p "$($1)"
  chmod $2 "$($1)"
  chown "$($3)" "$($1)"
}