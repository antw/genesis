genesis_run_recipe() {
  if [[ "$1" = "" ]] ; then
    echo "Ran genesis_run_recipe with no recipe name"
  elif [ -f "./recipes/$1.sh" ] ; then
    genesis_say_header "Running recipe: $1"
    source "./recipes/$1.sh"
  else
    echo "No such recipes: $1"
    exit 1
  fi
}
