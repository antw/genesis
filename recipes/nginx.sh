# Recipe to install nginx from the Ubuntu Personal Package Archive, since it's
# much more up-to-date than the normal package.
add-apt-repository ppa:nginx/stable

apt-get update
apt-get install nginx
