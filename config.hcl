ui = true
cluster_addr  = "https://0.0.0.1:8201"
api_addr      = "https://0.0.0.0:8200"
disable_mlock     = true

storage "raft" {
  path = "/vault/data"
}

listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_disable = true
#  tls_cert_file = "/opt/vault/tls/tls.crt"
#  tls_key_file  = "/opt/vault/tls/tls.key"
}
