remote_state {
    backend = "azurerm"
        config = {
            resource_group_name  = "${get_env("AZURE_BACKEND_RG_NAME", "")}"
            storage_account_name = "${get_env("AZURE_BACKEND_STORAGE_NAME", "")}"
            container_name       = "${get_env("AZURE_BACKEND_CONTAINER_NAME", "")}"
            access_key           = "${get_env("AZURE_BACKEND_ACCESS_KEY", "")}"
            key                  = "spk1.${path_relative_to_include()}/terraform.tfstate"
    }
}

inputs = {
    # BYO Resource Group
    resource_group_name      = "nr-spk-infra-tests-rg"
    agent_vm_count           = "3"
    dns_prefix               = "spk-dns-prefix"
    vnet_name                = "spk-vnet"
    service_principal_id     = "${get_env("AZURE_CLIENT_ID", "")}"
    service_principal_secret = "${get_env("AZURE_CLIENT_SECRET", "")}"
}
