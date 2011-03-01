__init_dry_run() {
  cat </dev/null > "${genesis_path}/log/dry-run.txt"

  echo "#/usr/bin/env bash" >> "${genesis_path}/log/dry-run.txt"
  echo "set -o errexit"     >> "${genesis_path}/log/dry-run.txt"
  echo ""                   >> "${genesis_path}/log/dry-run.txt"

  # Add Ubuntu requirement to the dry run.
  cat "${genesis_path}/lib/os-requirement.sh" >> \
    "${genesis_path}/log/dry-run.txt"

  echo "" >> "${genesis_path}/log/dry-run.txt"
}
