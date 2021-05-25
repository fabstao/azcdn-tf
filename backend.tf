terraform {
  backend "azurerm" {
    storage_account_name = "lzdeploytfstatelatam"
    container_name       = "lzdpltfstatecontainer"
    key                  = "terraform-suracdn.tfstate"
    resource_group_name  = "LATAMPSSandbox"
  }
}
