#/usr/bin/env bash

# Main script for setting up new servers. Call with a single argument:
# the name of the server script (in /servers) without the trailing .sh
#
# For example:
#
#   ssh -t user@server "./genesis.sh app-server"
#

# Genesis setup.

set -o nounset # Exit immediately if an unknown variable is encountered.
set -o errexit # Exit if any command exits with non-zero status.

genesis_path="$( cd "$( dirname "$0" )" && pwd )"

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
