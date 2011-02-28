# Says the given string ($1) prefixed with the current time.
#
# Example:
#
#   say_with_time "Starting something"
#   # => [17:32:04]    Starting something
#
say_with_time() {
  echo "[$(date '+%H:%M:%S')]    $1"
}

# Says the given string ($1) prefixed with the current time and a
# hashrocket.
#
# Example:
#
#   say_header "Starting something"
#   # => [17:32:04] => Starting something
#
say_header() {
  echo -e "\n[$(date '+%H:%M:%S')] => $1"
}
