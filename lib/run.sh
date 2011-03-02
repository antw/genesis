# Runs a command. This is used so that we can keep track of each
# command, and log it when doing a --dry-run.

run() {
  local cmd=$1

  if [[ "${genesis_dry_run:-"0"}" = '1' ]] ; then
    # If this is a dry run, we output the command to a file...
    echo "$cmd" >> "${genesis_dry_log}"
  elif [[ "${genesis_verbose:-""}" = '1' ]] ; then
    # Verbose mode is enabled, just run the command.
    eval "${cmd}"
  else
    # Silence output, and run command.
    eval "${cmd} 1>>"${genesis_run_log}" 2>&1"
  fi
}
