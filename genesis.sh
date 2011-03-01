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

# Require Ubuntu 10.04 for now.

if [ -f "/etc/lsb-release" ] ; then
  source /etc/lsb-release
  if [[ ! $DISTRIB_RELEASE = '10.04' ]] ; then
    echo "Genesis requires Ubuntu 10.04. You have $DISTRIB_RELEASE"
    exit 1
  fi
else
  echo "Nothing found at /etc/lsb-release. Not Ubuntu?"
  exit 1
fi

# Arguments.

case "$1" in
  --dry-run) declare -r genesis_dry_run=1 ; shift ;;
  --verbose) declare -r genesis_verbose=1 ; shift ;;
esac

# Genesis setup.

declare -r genesis_path="$( cd "$( dirname "$0" )" && pwd )"
declare -r genesis_tmp_path="$genesis_path/tmp"

if [[ "${genesis_dry_run:-""}" = '1' ]] ; then
  cat </dev/null > "${genesis_path}/log/dry-run.txt"
fi

# Load lib/*

for file in $genesis_path/lib/*.sh ; do
  source $file
done

# Off we go...!

if [ -f "$genesis_path/servers/$1.sh" ] ; then
  run_recipe "bootstrap"
  run_recipe "openssh"

  run_server $1
  say_header "All done!"

  if [[ "${genesis_dry_run:-""}" = '1' ]] ; then
    say_with_time "Dry run log saved to log/dry-run.txt"
  fi
else
  echo "No such server: $1"
  exit 1
fi
