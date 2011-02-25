#/usr/bin/env bash

# Main script for setting up new servers. Call with a single argument:
# the name of the server script (in /servers) without the trailing .sh
#
# For example:
#
#   ssh -t user@server "bash setup.sh app-server"
#

# Load lib/*

for file in lib/*.sh ; do
  source $file
done

# Off we go...!

if [ -f "./servers/$1.sh" ] ; then
  source "./servers/$1.sh"
  genesis_say_header "All done!"
else
  echo "No such server: ./servers/$1.sh"
fi
