output "webserver_ip" {
    value = azurerm_public_ip.webserver_1.ip_address
}