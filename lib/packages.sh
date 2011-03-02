# Contains functions for helping manage package and recipe dependencies
# so that each one is run at most once.

declare -a installed_packages

# For some reason, these need an empty element or Bash complains that
# the variables aren't set.
installed_packages=( '' )

# Package which needs to be installed.
install_package() {
  local package_name=$1

  if [ $( array_contains ${package_name} ${installed_packages[@]} ) = -1 ] ; then
    say "Installing package: ${package_name}"
    run "aptitude install -y -q ${package_name}"
    array_push 'installed_packages' "${package_name}"
  fi

  return 0
}
