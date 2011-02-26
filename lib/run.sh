# Runs a single recipe. Expected to be at $genesis_path/recipes/$1.sh
#
genesis_run_recipe() {
  [[ ! "$1" = "" ]] && genesis_say_header "Running recipe: $1"
  __genesis_run_component "recipe" $1
}

# Runs a single role. Expected to be at $genesis_path/roles/$1.sh
#
genesis_run_role() {
  __genesis_run_component "role" $1
}

# Runs a single server declaration. Expected to be at
# $genesis_path/servers/$1/run.sh
#
genesis_run_server() {
  __genesis_run_component "server" $1
}

# Runs something; a recipe, role, or server.
#
# $1 = A noun: "recipe", "role", or "server".
# $2 = A thing: e.g. "rails", "app-server", etc.
#
__genesis_run_component() {

  local component_dir="$genesis_path/$1s/$2"
  # naive pluralisation - - - - - - - ^

  if [[ "$2" = "" ]] ; then
    echo "Ran genesis_run_$1 with no $1 provided"
    exit 1

  elif [ -d "$component_dir" ] ; then
    # Some components may lack a run file (such as those which simply
    # copy files across).
    [ -f "$component_dir/run.sh" ] && source "$component_dir/run.sh"

    # If the recipe has any fixture files, copy them.
    [ -d "$component_dir/files" ] && copy -r "$component_dir/files" /

    # If the recipe has an after "filter", run it now.
    [ -f "$component_dir/after.sh" ] && source "$component_dir/after.sh"

    return 0

  else
    echo "No such $1: $2"
    exit 1

  fi

}
