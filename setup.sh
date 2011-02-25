#/usr/bin/env bash

# Main script for setting up new servers. Call with a single argument:
# the name of the server script (in /servers) without the trailing .sh
#
# For example:
#
#   ssh -t user@server "./setup.sh app-server"
#

# Genesis setup.

genesis_path="$( cd "$( dirname "$0" )" && pwd )"
echo $genesis_path

# Load lib/*

for file in $genesis_path/lib/*.sh ; do
  source $file
done

# Off we go...!

if [ -f "$genesis_path/servers/$1.sh" ] ; then
  genesis_run_recipe "bootstrap"
  source "$genesis_path/servers/$1.sh"
  genesis_say_header "All done!"
else
  echo "No such server: $1"
fi
