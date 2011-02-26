#/usr/bin/env bash

# Main script for setting up new servers. Call with a single argument:
# the name of the server script (in /servers) without the trailing .sh
#
# For example:
#
#   ssh -t user@server "./genesis.sh app-server"
#

set -o nounset # Exit immediately if an unknown variable is encountered.
set -o errexit # Exit if any command exits with non-zero status.

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

# Genesis setup.

declare -r genesis_path="$( cd "$( dirname "$0" )" && pwd )"

# Load lib/*

for file in $genesis_path/lib/*.sh ; do
  source $file
done

# Off we go...!

if [ -d "$genesis_path/servers/$1" ] ; then
  genesis_run_recipe "bootstrap"
  genesis_run_server $1
  genesis_say_header "All done!"
else
  echo "No such server: $1"
fi
