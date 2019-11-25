provider "azurerm" {}

resource "tls_private_key" "ssh_key" {
  algorithm   = "RSA"
  ecdsa_curve = "2048"
}

resource "local_file" "ssh_private_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "${path.module}/ssh.key"
}

module "vnet" {
  source           = "git::https://github.com/timarenz/terraform-azurerm-environment.git?ref=v0.2.0"
  environment_name = var.environment
  owner_name       = var.owner
  region           = "West Europe"
  subnets = [{
    name   = "subnet-1"
    prefix = "192.168.42.0/24"
  }]
}
