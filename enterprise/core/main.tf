provider "azurerm" {}

module "vnet" {
  source           = "app.terraform.io/timarenz/environment/azurerm"
  version          = "0.2.0"
  environment_name = var.environment
  owner_name       = var.owner
  region           = "West Europe"
  subnets = [{
    name   = "subnet-1"
    prefix = "192.168.42.0/24"
  }]
}

  module "vnet" {
  source           = "app.terraform.io/timarenz/environment/azurerm"
  version          = "0.2.0"
  environment_name = var.environment
  owner_name       = var.owner
  region           = "West Europe"
  subnets = [{
    name   = "subnet-2"
    prefix = "192.168.43.0/24"
  }]
}
