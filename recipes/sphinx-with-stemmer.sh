# Installs the Sphinx search engine from source, using mysql, and libstemmer.
#

# Prerequisites.
# ----------------------------------------------------------------------------

install_package 'build-essential'
run_recipe 'mysql-client'

# Recipe.
# ----------------------------------------------------------------------------

run "rm -rf ${genesis_tmp_path}/sphinx-0.9.9"

say_with_time 'Fetching sphinx...'
retrieve_file 'sphinx-0.9.9.tar.gz' \
  'http://sphinxsearch.com/files/sphinx-0.9.9.tar.gz' 'cc2b535e'

say_with_time 'Extracting sphinx...'
run "( cd ${genesis_tmp_path} > /dev/null ; tar -zxvf sphinx-0.9.9.tar.gz ; )"

say_with_time 'Fetching libstemmer...'
retrieve_file 'libstemmer_c.tgz' \
  'http://snowball.tartarus.org/dist/libstemmer_c.tgz' 'ce3c26b7'

say_with_time 'Extracting libstemmer...'
run "( cd ${genesis_tmp_path} > /dev/null ; tar -C ${genesis_tmp_path}/sphinx-0.9.9 -zxvf libstemmer_c.tgz ; )"

say_with_time 'Configuring sphinx...'
run "( cd ${genesis_tmp_path}/sphinx-0.9.9 > /dev/null ; ./configure --with-mysql --with-stemmer ; )"

say_with_time 'Compiling sphinx...'
run "( cd ${genesis_tmp_path}/sphinx-0.9.9 > /dev/null ; make ; )"

say_with_time 'Installing sphinx...'
run "( cd ${genesis_tmp_path}/sphinx-0.9.9 > /dev/null ; make install ; )"
