resource "azurerm_public_ip" "lb" {
  name                = "loadbalancers-public-ip"
  resource_group_name = data.terraform_remote_state.core.outputs.rg_name
  location            = data.terraform_remote_state.core.outputs.rg_location
  allocation_method   = "Static"
}

resource "azurerm_lb" "lb" {
  name                = "loadbalancer"
  resource_group_name = data.terraform_remote_state.core.outputs.rg_name
  location            = data.terraform_remote_state.core.outputs.rg_location

  frontend_ip_configuration {
    name                 = "loadbalancer-public-ip"
    public_ip_address_id = azurerm_public_ip.lb.id
  }
}

resource "azurerm_lb_backend_address_pool" "webserver" {
  resource_group_name = data.terraform_remote_state.core.outputs.rg_name
  name                = "webserver-pool"
  loadbalancer_id     = azurerm_lb.lb.id
}

resource "azurerm_network_interface_backend_address_pool_association" "webserver_1" {
  network_interface_id    = azurerm_network_interface.webserver_1.id
  ip_configuration_name   = "webserver-1-private-ip"
  backend_address_pool_id = azurerm_lb_backend_address_pool.webserver.id
}

resource "azurerm_network_interface_backend_address_pool_association" "webserver_2" {
  network_interface_id    = azurerm_network_interface.webserver_2.id
  ip_configuration_name   = "webserver-2-private-ip"
  backend_address_pool_id = azurerm_lb_backend_address_pool.webserver.id
}

resource "azurerm_lb_rule" "main" {
  resource_group_name            = data.terraform_remote_state.core.outputs.rg_name
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "webserver-http"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.webserver.id
  protocol                       = "tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "loadbalancer-public-ip"
}
