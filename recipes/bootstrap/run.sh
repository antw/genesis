# This recipe should be run on all new servers in order to perform
# general setup tasks.

aptitude update

# Required for CRC checks.
aptitude install -y libarchive-zip-perl
