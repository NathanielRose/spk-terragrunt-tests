inputs = {
    # BYO Resource Group
    resource_group_name      = "nr-spk-infra-tests-rg"
    agent_vm_count           = "3"
    dns_prefix               = "spk-dns-prefix"
    vnet_name                = "spk-vnet"
    service_principal_id          = "${get_env("AZURE_CLIENT_ID", "")}"
    service_principal_secret      = "${get_env("AZURE_CLIENT_SECRET", "")}"
}