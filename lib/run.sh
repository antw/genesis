# Runs a single recipe. Expected to be at $genesis_path/recipes/$1.sh
#
genesis_run_recipe() {
  if [[ "$1" = "" ]] ; then
    echo "Ran genesis_run_recipe with no recipe name"

  elif [ -f "$genesis_path/recipes/$1.sh" ] ; then
    genesis_say_header "Running recipe: $1"
    source "$genesis_path/recipes/$1.sh"

  else
    echo "No such recipe: $1"
    exit 1

  fi
}

# Runs a single role. Expected to be at $genesis_path/roles/$1.sh
#
genesis_run_role() {
  if [[ "$1" = "" ]] ; then
    echo "Ran genesis_run_role with no role name"

  elif [ -f "$genesis_path/roles/$1.sh" ] ; then
    source "$genesis_path/roles/$1.sh"

  else
    echo "No such role: $1"
    exit 1

  fi
}
