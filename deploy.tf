terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "react-app-test1" {
  name     = "react-app-test1"
  location = "East US"
}

resource "azurerm_app_service_plan" "react-app-test1" {
  name                = "react-app-test1"
  location            = azurerm_resource_group.react-app-test1.location
  resource_group_name = azurerm_resource_group.react-app-test1.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "react-app-test1" {
  name                = "react-app-appservice"
  location            = azurerm_resource_group.react-app-test1.location
  resource_group_name = azurerm_resource_group.react-app-test1.name
  app_service_plan_id = azurerm_app_service_plan.react-app-test1.id

  site_config {
    linux_fx_version = "DOCKER|jharajltp/java-app:latest"
  }

  tags = {
    environment = "react-app"
  }
}