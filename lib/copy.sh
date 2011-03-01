# Copies files for a recipe.
#
copy_recipe_files() {
  copy_component_files "recipe" $1
}

# Copies files for a role.
#
copy_role_files() {
  copy_component_files "role" $1
}

# Copies files for a server.
#
copy_server_files() {
  copy_component_files "server" $1
}


# Copies files for a component.
copy_component_files() {
  local component_dir="$genesis_path/$1s/$2"
  # naive pluralisation - - - - - - - ^

  if [ -d "$component_dir" ] ; then
    say "Copying $2 $1 files"
    run "cp -r $component_dir/* /"
  else
    echo "No files to copy at $component_dir"
    exit 1
  fi

  return 0
}
