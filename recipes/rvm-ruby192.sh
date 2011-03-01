# Installs a system-wide version of Ruby 1.9.2 using RVM. Use of this
# recipe requires that the "rvm" recipe be used first.
#

say_with_time 'Installing Ruby 1.9.2 (may take a few minutes)'
run "/usr/local/bin/rvm install '1.9.2'"
run "/usr/local/bin/rvm use '1.9.2' --default"
