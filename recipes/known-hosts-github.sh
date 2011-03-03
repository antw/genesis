# Adds Github to the known_hosts file.

# The users for whom, by default, add the known_hosts. Override this in
# your servers if this isn't suitable for you.
#
# For example:
#
#   github_known_host_users=( antw sebastian root )
#
if [[ -z "${github_known_host_users}" ]] ; then
  github_known_host_users=( $USER $SUDO_USER )
fi

# Given a username, tests to see whether they need to have the SSH key
# added to their .ssh/known_hosts file, and adds it if necessary.
__add_github_known_host() {
  local user=$1
  local user_dir=$( cat /etc/passwd | grep "${user}" | cut -d':' -f6 )
  local known_hosts="${user_dir}/.ssh/known_hosts"

  run "mkdir -p '${user_dir}/.ssh'"
  say "Adding Github SSH key for ${user}"

  # Remove the key if it is already present.
  if [[ -f "${known_hosts}" ]] ; then
    run "ssh-keygen -R github.com -f '${known_hosts}'"
    run "chown '${user}:${user}' '${known_hosts}.old'"
  fi

  run "( cat '${genesis_path}/recipes/known-hosts-github/known_hosts' >> '${known_hosts}' ; )"
  run "chown '${user}:${user}' '${known_hosts}'"
}

# Recipe.
# ----------------------------------------------------------------------------

for __user in ${github_known_host_users[*]} ; do
  __add_github_known_host "${__user}"
done
