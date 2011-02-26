# Given a file name, looks in ./tmp to see if it exists, and matches the
# given CRC number. If the file does not exist, or the CRC check fails,
# the file will be re-downloaded.
#
# $1 = file name
# $2 = download URL
# $3 = crc
#
retrieve_file() {
  if [ -f "$genesis_tmp_path/$1" ] ; then
    if [[ ! `crc32 "$genesis_tmp_path/$1"` = $3 ]] ; then
      # File exists, but CRC32 is wrong.
      rm "$genesis_tmp_path/$1"
    fi
  fi

  # If file doesn't exist, download it.
  if [ ! -f "$genesis_tmp_path/$1" ] ; then
    wget $2 "$genesis_tmp_path/$1"

    if [[ ! `crc32 "$genesis_tmp_path/$1"` = $3 ]] ; then
      # File exists, but CRC32 is wrong.
      rm "$genesis_tmp_path/$1"
      echo "Wrong CRC: $1"
      exit 1
    fi
  fi
}
