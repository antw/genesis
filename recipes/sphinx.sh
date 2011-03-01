# Installs the Sphinx search engine using Ubuntu packages. No stemmer
# support, as far as I know.
#

run_recipe 'mysql-client'
install_package 'sphinxsearch'
