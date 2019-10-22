inputs = {
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
  path = find_in_parent_folders()
}

dependency "azure-common-infra-west" {
  config_path = "../azure-common-infra-west"

  mock_outputs = {
    vnet_subnet_id = "/subscriptions/<subscriptionId>/resourceGroups/myResourceGroup/providers/Microsoft.Network/virtualNetworks/myVnet/subnets/mock-Subnet"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  #Dependency on vnet_subnet_id
  skip_outputs = true
}