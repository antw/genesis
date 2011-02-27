# Copies files for a recipe.
#
genesis_copy_recipe_files() {
  __genesis_copy_component_files "recipe" $1
}

# Copies files for a role.
#
genesis_copy_role_files() {
  __genesis_copy_component_files "role" $1
}

# Copies files for a server.
#
genesis_copy_server_files() {
  __genesis_copy_component_files "server" $1
}


# Copies files for a component.
__genesis_copy_component_files() {
  local component_dir="$genesis_path/$1s/$2"
  # naive pluralisation - - - - - - - ^

  if [ -d "$component_dir" ] ; then
    genesis_say_with_time "Copying $2 $1 files"
    cp -r $component_dir/* /
  else
    echo "No files to copy at $component_dir"
    exit 1
  fi

  return 0
}
