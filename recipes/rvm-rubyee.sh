# Installs a system-wide version of Ruby Enterprise Edition using RVM. Use of
# this recipe requires that the "rvm" recipe be used first.
#

say 'Installing Ruby EE (may take a few minutes)'
run "/usr/local/bin/rvm install 'ree'"
