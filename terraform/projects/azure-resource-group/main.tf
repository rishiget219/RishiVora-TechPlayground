resource "azurerm_resource_group" "RG-test" {
  for_each = var.azurerm_resource_name
  name     = each.value.name
  location = each.value.location
}
