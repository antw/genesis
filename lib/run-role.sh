genesis_run_role() {
  if [[ "$1" = "" ]] ; then
    echo "Ran genesis_run_role with no role name"
  elif [ -f "./roles/$1.sh" ] ; then
    genesis_say_with_time "Starting role: $1"
    source "./roles/$1.sh"
    genesis_say_with_time "Finished role: $1"
  else
    echo "No such role: $1"
    exit 1
  fi
}
