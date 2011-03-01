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
#   # [17:32:04] => Starting something
#
say_header() {
  echo -e "[$(date '+%H:%M:%S')] => $1"
}

# Says the given string ($1) prefixed with the current time and a
# reverse hashrocket.
#
# Example:
#
#   say_end_header "Finished something"
#   # [17:32:04] <= Finished something
#
say_end_header() {
  echo -e "[$(date '+%H:%M:%S')] <= $1"
}

# Says the given string ($1) prefixed with the current time, and some
# exclamations.
#
# Example:
#
#   say_end_header "Imperial troops have entered the base!"
#   # [17:32:04] !! Imperial troops have entered the base!
#
say_error() {
  echo -e "[$(date '+%H:%M:%S')] !! $1"
}
