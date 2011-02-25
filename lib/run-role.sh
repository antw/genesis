genesis_run_role() {
  if [[ "$1" = "" ]] ; then
    echo "Ran genesis_run_role with no role name"
  elif [ -f "./roles/$1.sh" ] ; then
    source "./roles/$1.sh"
  else
    echo "No such role: $1"
    exit 1
  fi
}
