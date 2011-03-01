#/usr/bin/env bash

# Main script for setting up new servers. Call with a single argument:
# the name of the server script (in /servers) without the trailing .sh
#
# For example:
#
#   ssh -t user@server "./genesis.sh app-server"
#

set -o errexit    # Exit if any command exits with non-zero status.
shopt -s extglob  # Extended globs

# Arguments.

case "$1" in
  --dry-run)      declare -r genesis_dry_run=1 ; shift ;;
  --verbose)      declare -r genesis_verbose=1 ; shift ;;
  --no-bootstrap) declare -r genesis_no_boot=1 ; shift ;;
esac

# Genesis setup.

declare -r genesis_path="$( cd "$( dirname "$0" )" && pwd )"
declare -r genesis_tmp_path="$genesis_path/tmp"

# Load lib/*

for file in $genesis_path/lib/*.sh ; do
  if [[ $(basename $file) = "os-requirement.sh" ]] ; then
    if [[ "${genesis_dry_run:-"0"}" = '1' ]] ; then
      # Don't require Ubuntu when doing dry runs.
      continue
    fi
  fi

  source $file
done

# Set up logs, and dry run.

cat </dev/null > "${genesis_path}/log/run-log.txt"

if [[ "${genesis_dry_run:-""}" = '1' ]] ; then
  __init_dry_run
fi

# Off we go...!

if [ -f "$genesis_path/servers/$1.sh" ] ; then
  if [[ "${genesis_no_boot:-"0"}" = "0" ]] ; then
    # Skip bootstrap if --no-bootstrap
    run_recipe "bootstrap"
    run_recipe "openssh"
  fi

  run_server $1
  say_header "All done!"

  if [[ "${genesis_dry_run:-""}" = '1' ]] ; then
    say_with_time "Dry run log saved to log/dry-run.txt"
  fi
else
  echo "No such server: $1"
  exit 1
fi
