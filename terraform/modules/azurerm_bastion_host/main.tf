resource "azurerm_bastion_host" "bastion" {
  for_each = var.bastion
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = each.value.ip
    subnet_id            = data.azurerm_subnet.snetdata[each.value.snet_id].id
    public_ip_address_id = data.azurerm_public_ip.snetIP[each.value.pip_id].id
  }
}