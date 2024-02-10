terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.85.0"
    }
  }
  backend "azurerm" {
    //provide staorage account name here where state file will store.

  }

}

provider "azurerm" {

  features {

  }

}

resource "azurerm_resource_group" "rg" {
  name     = var.resourcegroupname
  location = var.location


}


resource "azurerm_service_plan" "azureapp" {
  name                = var.appservice
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_name            = "F1"
  os_type             = "Windows"




}
resource "azurerm_windows_web_app" "webapp" {

  name                = var.webapp
  location            = azurerm_service_plan.azureapp.location
  resource_group_name = azurerm_service_plan.azureapp.resource_group_name
  service_plan_id     = azurerm_service_plan.azureapp.id


  site_config {
    always_on = false
    application_stack {
      current_stack = "node"
      node_version  = "~18"
    }
  }
}
