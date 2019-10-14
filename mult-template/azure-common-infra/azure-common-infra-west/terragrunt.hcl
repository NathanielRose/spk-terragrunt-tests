inputs = {
    # BYO Resource Group
    global_resource_group_name = "nr-spk-infra-tests-rg"
    vnet_name = "spkvnet"
    subnet_name = "spksubnet"
    subnet_prefix = "10.39.0.0/24"
    address_space = "10.39.0.0/16"
    keyvault_name = "spkkeyvault"
    service_principal_id = "${get_env("AZURE_CLIENT_ID", "")}"
    tenant_id = "${get_env("AZURE_TENANT_ID", "")}"
}