provider "azurerm" {
  features {}
}

# Create a resourse group

resource "azurerm_resource_group" "resource_group" {
  name     = var.rg-name
  location = var.location
}

# Create a storage account
resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage-account-name
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  static_website {
    index_document = "index.html"
  }
}

# Add an index.html file from a folder within the repo
resource "azurerm_storage_blob" "blob" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source_content         = var.source_content
}






