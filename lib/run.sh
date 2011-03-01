# Runs a command. This is used so that we can keep track of each
# command, and log it when doing a --dry-run.

run() {
  local cmd=$1

  if [[ 0 -eq 1 ]] ; then
    # If this is a dry run, we output the command to a file...
    # Not yet implemented.
    echo 'How did you get here?'
  elif [[ 0 -eq 1 ]] ; then
    # Verbose mode is enabled, just run the command.
    # Verbose mode? Not yet implemented.
    echo '... or here?!'
  else
    # Silence output, and run command.
    # Todo, output errors to ./log/run-log.txt
    eval "${cmd} 1>/dev/null 2>&1"
  fi
}
