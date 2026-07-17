 data "azurerm_subnet" "snetdata"{
  for_each = var.snet
  name                 = each.value.name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "snetIP" {
    for_each = var.pip
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}