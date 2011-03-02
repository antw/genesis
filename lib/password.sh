# Generates a random 32-character password using OpenSSL.
openssl_random_password() {
  echo $(openssl rand -hex 16)
}
