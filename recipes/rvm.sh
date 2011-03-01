# Performs a system-wide installation of RVM. RVM will be available to
# all users of the system.
#
# See: http://rvm.beginrescueend.com/deployment/system-wide/
#
# After using the RVM recipe, you need to add users to the rvm group,
# otherwise they won't be able to use it.
#
# For example:
#
#   $ usermod -a -G rvm $user
#
# After installing, you also need to source RVM in your shell profile,
# otherwise it won't be available:
#
#  source '/usr/local/lib/rvm'
#

run 'install_package "curl"'
run 'bash < <( curl -L http://bit.ly/rvm-install-system-wide )'

# Packages required for building Ruby.
install_package 'build-essential'
install_package 'zlib1g-dev'
install_package 'libssl-dev'
install_package 'libreadline5-dev'
