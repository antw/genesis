# Keeps track of which recipes have been run, so that it is safe to call
# run_recipe multiple times with the same recipe, without having to
# worry about repeating work.
declare -a run_recipes
run_recipes=( '' )

# Runs a single recipe. Expected to be at $path/recipes/$1.sh
#
run_recipe() {
  local recipe_name=$1

  if [ $( array_contains ${recipe_name} ${run_recipes[@]} ) = -1 ] ; then
    say_header "Running recipe: ${recipe_name}"
    __run_component "recipe" "${recipe_name}"
    array_push 'run_recipes' "${recipe_name}"
    say_end_header "Finished recipe: ${recipe_name}"
  fi

  return 0
}

# Runs a single role. Expected to be at $path/roles/$1.sh
#
run_role() {
  __run_component "role" $1
}

# Runs a single server declaration. Expected to be at
# $path/servers/$1/run.sh
#
run_server() {
  __run_component "server" $1
}

# Runs something; a recipe, role, or server.
#
# $1 = A noun: "recipe", "role", or "server".
# $2 = A thing: e.g. "rails", "app-server", etc.
#
__run_component() {

  local type=$1
  local name=$2
  local path="${genesis_path}/${type}s/${name}.sh"
  # naive pluralisation - - - - - - ^

  if [[ "${name}" = "" ]] ; then
    echo "Called run_${type} with no ${name} provided"
    exit 1

  elif [ -f "${path}" ] ; then
    source "${path}"
    return 0

  else
    echo "No such ${type}: ${path}"
    exit 1

  fi

}
