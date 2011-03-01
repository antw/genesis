__init_dry_run() {
  cat </dev/null > "${genesis_dry_log}"

  echo "#/usr/bin/env bash" >> "${genesis_dry_log}"
  echo "set -o errexit"     >> "${genesis_dry_log}"
  echo ""                   >> "${genesis_dry_log}"

  # Add Ubuntu requirement to the dry run.
  cat "${genesis_path}/lib/os-requirement.sh" >> "${genesis_dry_log}"

  echo "" >> "${genesis_dry_log}"
}
