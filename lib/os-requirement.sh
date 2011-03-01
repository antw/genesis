# Require Ubuntu 10.04 for now.

if [ -f "/etc/lsb-release" ] ; then
  source /etc/lsb-release
  if [[ ! $DISTRIB_RELEASE = '10.04' ]] ; then
    echo "Genesis requires Ubuntu 10.04. You have $DISTRIB_RELEASE"
    exit 1
  fi
else
  echo "Nothing found at /etc/lsb-release. Not Ubuntu?"
  exit 1
fi
