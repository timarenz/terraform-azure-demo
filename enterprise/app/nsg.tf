resource "azurerm_network_security_group" "webserver" {
  name                = "werverserver-security-group"
  resource_group_name = data.terraform_remote_state.core.outputs.rg_name
  location            = data.terraform_remote_state.core.outputs.rg_location

  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "werverserver-ssh-any"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.terraform_remote_state.core.outputs.rg_name
  network_security_group_name = azurerm_network_security_group.webserver.name
}

resource "azurerm_network_security_rule" "http" {
  name                        = "werverserver-http-any"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.terraform_remote_state.core.outputs.rg_name
  network_security_group_name = azurerm_network_security_group.webserver.name
}

resource "azurerm_network_security_rule" "egress" {
  name                        = "werverserver-egress-any"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.terraform_remote_state.core.outputs.rg_name
  network_security_group_name = azurerm_network_security_group.webserver.name
}
