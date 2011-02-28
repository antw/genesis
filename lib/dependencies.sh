# Contains functions for helping manage package and recipe dependencies
# so that each one is run at most once.

declare -a package_deps
declare -a recipe_deps

# For some reason, these need an empty element or Bash complains that
# the variables aren't set.
package_deps=( '' )
recipe_deps=( '' )

# Package which needs to be installed.
install_package() {
  local package_name=$1

  if [ $( array_contains $package_name ${package_deps[@]} ) = -1 ] ; then
    say_with_time "Installing package: $package_name"
    aptitude install -y $package_name
    array_push 'package_deps' $package_name
  fi

  return 0
}
