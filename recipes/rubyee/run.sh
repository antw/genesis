# Install prerequisites
aptitude install -y zlib1g-dev libssl-dev libreadline5-dev

__install_ruby_enterprise () {
  case `uname -m` in
    *i[3-6]86*)
      local file="ruby-enterprise_1.8.7-2011.03_i386_ubuntu10.04.deb"
      local crc="d09fc204"
      ;;
    "x86_64")
      local file="ruby-enterprise_1.8.7-2011.03_amd64_ubuntu10.04.deb"
      local crc="8feec651"
      ;;
    *)
      echo "Unknown ree architecture" && exit 1 ;;
  esac

  retrieve_file \
    $file \
    "http://rubyenterpriseedition.googlecode.com/files/$file" \
    $crc

  dpkg --install "$genesis_tmp_path/$file"
}

__install_ruby_enterprise