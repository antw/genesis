#/usr/bin/env bash

# Main script for setting up new servers. Call with a single argument:
# the name of the server script (in /servers) without the trailing .sh
#
# For example:
#
#   ssh -t user@server "./genesis.sh app-server"
#

set -o errexit    # Exit if any command exits with non-zero status.
set -o errtrace
shopt -s extglob  # Extended globs

# Arguments.

while [ "$1" != "" ] ; do
  case "$1" in
    --dry-run)      declare -r genesis_dry_run=1 ;;
    --verbose)      declare -r genesis_verbose=1 ;;
    --no-bootstrap) declare -r genesis_no_boot=1 ;;
    *)                         server_name="$1"  ;;
  esac

  shift
done

# Genesis setup.

declare -r genesis_path="$( cd "$( dirname "$0" )" && pwd )"
declare -r genesis_tmp_path="${genesis_path}/tmp"
declare -r genesis_run_log="${genesis_path}/log/run.log"
declare -r genesis_dry_log="${genesis_path}/log/dry-run.sh.txt"

# Load lib/*

for file in ${genesis_path}/lib/*.sh ; do
  if [[ $(basename ${file}) = "os-requirement.sh" ]] ; then
    if [[ "${genesis_dry_run:-"0"}" = '1' ]] ; then
      # Don't require Ubuntu when doing dry runs.
      continue
    fi
  fi

  source "${file}"
done

# Inform the user when something goes wrong: 1/HUP 2/INT 3/QUIT 15/TERM ERR
trap 'say_error "Something went wrong: look at logs/run.log"; exit' 1 2 3 15 ERR

# Set up logs, and dry run.

cat </dev/null > "${genesis_run_log}"

if [[ "${genesis_dry_run:-""}" = '1' ]] ; then
  __init_dry_run
fi

# Off we go...!

if [ -f "${genesis_path}/servers/${server_name}.sh" ] ; then
  if [[ "${genesis_no_boot:-"0"}" = "0" ]] ; then
    # Skip bootstrap if --no-bootstrap
    run_recipe "bootstrap"
    run_recipe "openssh"
  fi

  run_server "${server_name}"
  say_header "All done!"

  if [[ "${genesis_dry_run:-""}" = '1' ]] ; then
    say "Dry run log saved to log/dry-run.sh.txt"
  fi
else
  echo "No such server: ${server_name:-"None specified"}"
  exit 1
fi
