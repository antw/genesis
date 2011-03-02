# Given a file name, looks in ./tmp to see if it exists, and matches the
# given CRC number. If the file does not exist, or the CRC check fails,
# the file will be re-downloaded.
#
# $1 = file name
# $2 = download URL
# $3 = crc
#
retrieve_file() {
  local filename=$1
  local url=$2
  local crc=$3

  install_package 'curl'

  if [[ "${genesis_dry_run:-""}" = "1" ]] ; then
    # Not sure of the best way of handling remote files with dry runs,
    # so defaulting to fetching the file each time for now.
    run "( cd ${genesis_tmp_path} > /dev/null ; curl -L -s -O ${url} ; )"
  else

    # Required for CRC checks.
    install_package 'libarchive-zip-perl'

    if [ -f "${genesis_tmp_path}/${filename}" ] ; then
      if [[ `crc32 "${genesis_tmp_path}/${filename}"` != "$crc" ]] ; then
        # File exists, but CRC32 is wrong.
        rm "${genesis_tmp_path}/${filename}"
      fi
    fi

    # If file doesn't exist, download it.
    if [ ! -f "${genesis_tmp_path}/${filename}" ] ; then
      ( cd "${genesis_tmp_path}" > /dev/null ; curl -L -s -O "${url}" ; )

      if [[ `crc32 "${genesis_tmp_path}/${filename}"` = $crc ]] ; then
        # File exists, but CRC32 is wrong.
        rm "${genesis_tmp_path}/${filename}"
        say_error "Wrong CRC: ${filename}"
        exit 1
      fi
    fi

  fi
}

# Given a path to a file, a search string and a replacement string, uses
# sed to replace the search string. Uses a temporary file, so write
# permissions are required in the target directory.
#
replace_in() {
  local path=$1
  local search=$(__escape_for_sed "${2}")
  local replace=$(__escape_for_sed "${3}")
  local tmp="${path}.tmp"

  if [[ "${genesis_dry_run:-"0"}" = "0" ]] ; then
    if [[ ! -f "${path}" ]] ; then
      echo "No such file to replace in: ${path}"
      exit 1
    elif [[ ! -r "${path}" ]] ; then
      echo "File is not readable: ${path}"
      exit 1
    elif [[ ! -w "${path}" ]] ; then
      echo "File is not writable: ${path}"
      exit 1
    fi
  fi

  # sed needs to be wrapped in ( ... ) in order to get around
  # non-verbose mode redirecting output.
  run "( sed -e 's/##${search}##/${replace}/' '${path}' > '${tmp}' ; )"

  # Preserve permissions on the original by copying, rather than moving.
  run "cp -f ${tmp} ${path}"
  run "rm ${tmp}"

  return 0
}

# Escapes search and replace patterns making them safe for use in sed.
__escape_for_sed() {
  escaped=$(echo "${1}" | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\\&/g')
  echo $escaped
}
