data "azurerm_platform_image" "ubuntu" {
  location  = module.vnet.rg_location
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "16.04-LTS"
}

resource "azurerm_availability_set" "webserver" {
  name                = "webserver"
  resource_group_name = module.vnet.rg_name
  location            = module.vnet.rg_location
  managed             = true

  tags = {
    environment = var.environment
    costcenter  = "it"
  }
}

resource "azurerm_public_ip" "webserver_1" {
  name                = "webserver-1-public-ip"
  resource_group_name = module.vnet.rg_name
  location            = module.vnet.rg_location
  allocation_method   = "Static"

  tags = {
    environment = var.environment
    costcenter  = "it"
  }
}

resource "azurerm_network_interface" "webserver_1" {
  name                = "webserver-1-interface"
  resource_group_name = module.vnet.rg_name
  location            = module.vnet.rg_location

  ip_configuration {
    name                          = "webserver-1-private-ip"
    subnet_id                     = module.vnet.subnet_ids[0]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.webserver_1.id
  }

  network_security_group_id = azurerm_network_security_group.webserver.id

  tags = {
    environment = var.environment
    costcenter  = "it"
  }
}

resource "azurerm_virtual_machine" "webserver_1" {
  name                  = "webserver-1"
  resource_group_name   = module.vnet.rg_name
  location              = module.vnet.rg_location
  network_interface_ids = [azurerm_network_interface.webserver_1.id]
  vm_size               = var.vm_size
  availability_set_id   = azurerm_availability_set.webserver.id

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = data.azurerm_platform_image.ubuntu.publisher
    offer     = data.azurerm_platform_image.ubuntu.offer
    sku       = data.azurerm_platform_image.ubuntu.sku
    version   = data.azurerm_platform_image.ubuntu.version
  }

  storage_os_disk {
    name          = "webserver-1-osdisk"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "webserver-1"
    admin_username = "azureadmin"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/azureadmin/.ssh/authorized_keys"
      key_data = tls_private_key.ssh_key.public_key_openssh
    }
  }

  tags = {
    environment = var.environment
    costcenter  = "it"
  }
}

resource "azurerm_public_ip" "webserver_2" {
  name                = "webserver-2-public-ip"
  resource_group_name = module.vnet2.rg_name
  location            = module.vnet2.rg_location
  allocation_method   = "Static"

  tags = {
    environment = var.environment
    costcenter  = "it"
  }
}

resource "azurerm_network_interface" "webserver_2" {
  name                = "webserver-2-interface"
  resource_group_name = module.vnet2.rg_name
  location            = module.vnet2.rg_location

  ip_configuration {
    name                          = "webserver-2-private-ip"
    subnet_id                     = module.vnet2.subnet_ids[0]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.webserver_2.id
  }

  network_security_group_id = azurerm_network_security_group.webserver.id

  tags = {
    environment = var.environment
    costcenter  = "it"
  }
}

resource "azurerm_virtual_machine" "webserver_2" {
  name                  = "webserver-2"
  resource_group_name   = module.vnet2.rg_name
  location              = module.vnet2.rg_location
  network_interface_ids = [azurerm_network_interface.webserver_2.id]
  vm_size               = var.vm_size
  availability_set_id   = azurerm_availability_set.webserver.id

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = data.azurerm_platform_image.ubuntu.publisher
    offer     = data.azurerm_platform_image.ubuntu.offer
    sku       = data.azurerm_platform_image.ubuntu.sku
    version   = data.azurerm_platform_image.ubuntu.version
  }

  storage_os_disk {
    name          = "webserver-2-osdisk"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "webserver-2"
    admin_username = "azureadmin"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/azureadmin/.ssh/authorized_keys"
      key_data = tls_private_key.ssh_key.public_key_openssh
    }
  }

  tags = {
    environment = var.environment
    costcenter  = "it"
  }
}
