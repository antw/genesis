# Generates a random 20-character password using OpenSSL.
openssl_random_password() {
  echo $(openssl rand -base64 15)
}
