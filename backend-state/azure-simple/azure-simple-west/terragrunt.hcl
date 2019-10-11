include {
  path = find_in_parent_folders()
}

remote_state {
    backend = "azurerm"
        config = {
            resource_group_name  = "${get_env("AZURE_BACKEND_RG_NAME", "")}"
            storage_account_name = "${get_env("AZURE_BACKEND_STORAGE_NAME", "")}"
            container_name       = "${get_env("AZURE_BACKEND_CONTAINER_NAME", "")}"
            key                  = "spk.terraform.tfstate"
    }
}

inputs = {
    cluster_name             = "backend-spk-store"
    ssh_public_key           = "public-key"
    gitops_ssh_url           = "git@github.com:timfpark/fabrikate-cloud-native-manifests.git"
    gitops_ssh_key           = "<path to private gitops repo key>"
    key                       = "spkTESTER.terraform.tfstate"
}
