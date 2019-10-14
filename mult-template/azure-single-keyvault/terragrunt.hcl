inputs = {
    #--------------------------------------------------------------
    # keyvault, vnet, and subnets are created seperately by azure-common-infra
    #--------------------------------------------------------------
    keyvault_resource_group = dependency.azure-common-infra.inputs.global_resource_group_name
    keyvault_name = dependency.azure-common-infra.inputs.keyvault_name
    address_space = dependency.azure-common-infra.inputs.address_space
    subnet_prefixes = dependency.azure-common-infra.inputs.subnet_prefixes
    vnet_name = dependency.azure-common-infra.inputs.vnet_name
    vnet_subnet_id = dependency.azure-common-infra.outputs.vnet_subnet_id

    #--------------------------------------------------------------
    # Cluster variables
    #--------------------------------------------------------------
    agent_vm_count = "3"
    agent_vm_size = "Standard_D4s_v3"

    cluster_name = "azure-single-keyvault"
    dns_prefix = "azure-single-keyvault"

    gitops_ssh_url = "git@github.com:Microsoft/fabrikate-production-cluster-demo-materialized"
    gitops_ssh_key = "/full/path/to/gitops_repo_private_key"

    resource_group_name = "azure-single-keyvault-rg"

    ssh_public_key = "<ssh public key>"

    service_principal_id = "${get_env("AZURE_CLIENT_ID", "")}"
    service_principal_secret = "${get_env("AZURE_CLIENT_SECRET", "")}"
}

include {
    path = "${path_relative_to_include()}/../azure-common-infra/terragrunt.hcl"
}

remote_state {
    #disable_init = true
    backend = "azurerm"
    config = {
        resource_group_name  = "${get_env("AZURE_BACKEND_RG_NAME", "")}"
        storage_account_name = "${get_env("AZURE_BACKEND_STORAGE_NAME", "")}"
        container_name       = "${get_env("AZURE_BACKEND_CONTAINER_NAME", "")}"
        access_key           = "${get_env("AZURE_BACKEND_ACCESS_KEY", "")}"
        key                  = "spk1.${path_relative_to_include()}/terraform.tfstate"
    }
}

dependency "azure-common-infra" {
  config_path = "../azure-common-infra"

  mock_outputs = {
    # keyvault_name = "mock-Vault"
    # global_resource_group_name = "mock-rg"
    # address_space = "10.39.0.0/16"
    # subnet_prefixes = "10.39.0.0/24"
    # vnet_name = "mock-Vnet"
    vnet_subnet_id = "/subscriptions/<subscriptionId>/resourceGroups/myResourceGroup/providers/Microsoft.Network/virtualNetworks/myVnet/subnets/mock-Subnet"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  #Dependency on vnet_subnet_id
  skip_outputs = true
}