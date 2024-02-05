provider "vault" {
 address = "http://127.0.0.1:8200"
 skip_tls_verify = true
 token = "education"
}

data "vault_generic_secret" "vault_example" {
 path = "secret/example"
}

resource "vault_generic_secret" "chambers_of_secrets" {
  path = "secret/example"

  data_json = jsonencode({
    test = var.secret_data_value
  })
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
}