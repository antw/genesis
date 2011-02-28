# Runs a single recipe. Expected to be at $path/recipes/$1.sh
#
run_recipe() {
  [[ ! "$1" = "" ]] && say_header "Running recipe: $1"
  run_component "recipe" $1
}

# Runs a single role. Expected to be at $path/roles/$1.sh
#
run_role() {
  run_component "role" $1
}

# Runs a single server declaration. Expected to be at
# $path/servers/$1/run.sh
#
run_server() {
  run_component "server" $1
}

# Runs something; a recipe, role, or server.
#
# $1 = A noun: "recipe", "role", or "server".
# $2 = A thing: e.g. "rails", "app-server", etc.
#
run_component() {

  local component_path="$genesis_path/$1s/$2.sh"
  # naive pluralisation - - - - - - - ^

  if [[ "$2" = "" ]] ; then
    echo "Called run_$1 with no $1 provided"
    exit 1

  elif [ -f "$component_path" ] ; then
    source "$component_path"
    return 0

  else
    echo "No such $1: $2"
    exit 1

  fi

}
