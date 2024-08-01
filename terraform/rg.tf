resource "azurerm_resource_group" "rg" {
  name     = "rg-aks-apim"
  location = var.location
}