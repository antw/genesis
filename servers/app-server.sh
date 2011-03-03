# Add Github to our known_hosts list.
run_recipe "known-hosts-github"

run_role "rails"
run_role "memcached"
