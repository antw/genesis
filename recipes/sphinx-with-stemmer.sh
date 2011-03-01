# Installs the Sphinx search engine from source, using mysql, and libstemmer.
#

# Prerequisites.
# ----------------------------------------------------------------------------

install_package 'build-essential'
run_recipe 'mysql-client'

# Recipe.
# ----------------------------------------------------------------------------

run "rm -rf ${genesis_tmp_path}/sphinx-0.9.9"

say 'Fetching sphinx...'
retrieve_file 'sphinx-0.9.9.tar.gz' \
  'http://sphinxsearch.com/files/sphinx-0.9.9.tar.gz' 'cc2b535e'

say 'Extracting sphinx...'
run "( cd ${genesis_tmp_path} > /dev/null ; tar -zxvf sphinx-0.9.9.tar.gz ; )"

say 'Fetching libstemmer...'
retrieve_file 'libstemmer_c.tgz' \
  'http://snowball.tartarus.org/dist/libstemmer_c.tgz' 'ce3c26b7'

say 'Extracting libstemmer...'
run "( cd ${genesis_tmp_path} > /dev/null ; tar -C ${genesis_tmp_path}/sphinx-0.9.9 -zxvf libstemmer_c.tgz ; )"

say 'Configuring sphinx...'
run "( cd ${genesis_tmp_path}/sphinx-0.9.9 > /dev/null ; ./configure --with-mysql --with-stemmer ; )"

say 'Compiling sphinx...'
run "( cd ${genesis_tmp_path}/sphinx-0.9.9 > /dev/null ; make ; )"

say 'Installing sphinx...'
run "( cd ${genesis_tmp_path}/sphinx-0.9.9 > /dev/null ; make install ; )"
