# This recipe should be run on all new servers in order to perform
# general setup tasks.

say_with_time 'Updating installed packages'
run 'aptitude update'

# Required for CRC checks.
install_package 'libarchive-zip-perl'
