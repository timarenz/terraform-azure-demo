data "terraform_remote_state" "core" {
  backend = "remote"
  config = {
    organization = "timarenz"
    workspaces = {
      name = "azure-demo-core"
    }
  }
}

resource "tls_private_key" "ssh_key" {
  algorithm   = "RSA"
  ecdsa_curve = "2048"
}

resource "local_file" "ssh_private_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "${path.module}/ssh.key"
}
