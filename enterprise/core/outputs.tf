output "rg_name" {
  value = module.vnet.rg_name
}

output "rg_location" {
  value = module.vnet.rg_location
}

output "subnet_ids" {
  value = module.vnet.subnet_ids[*]
}
