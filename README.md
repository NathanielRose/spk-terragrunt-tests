# SPK + Terragrunt

Terragrunt is a thin wrapper for Terraform that provides extra tools for keeping your Terraform configurations DRY (Dont Repeat Yourself), working with multiple Terraform modules, and managing remote state. This repository is an investigation on the feasibility of using terragrunt for infrastructure scaffolding and generation detailed in the [Bedrock CLI Northstar](https://github.com/CatalystCode/bedrock-end-to-end-dx).

## Recursive Child Templates

Terragrunt configuration uses the exact language, HCL, as Terraform. We will use this to propogate common template configuration variables to child templates.
```
└── recursive
    └── azure-simple (base)
        ├── main.tf
        ├── terragrunt.hcl
        ├── variables.tf
        ├── azure-simple-east (deployment)
        │    ├── main.tf
        │    ├── terragrunt.hcl
        │    └── variables.tf
        |── azure-simple-west (deployment)
        │    ├── main.tf
        │    ├── terragrunt.hcl
        │    └── variables.tf
```

A few things to note:
- Note `.tfvars` have been removed as the terraform runtime will override terragrunt configurations upon configuration application
- In this example we are not using a remote backend state, tfstate wil be stored locally.
- Bedrock requires BYO Resource Group, so the location of the cluster will be dependent on the rg you provide.
- Iterating through terraform deployments are to be handled manually by the user.

In our **base** template is the bedrock azure-simple terraform environment. Here we provide our common infrastructure configurations such as `service-principal` and `resource_group_name`. Sensative secrets are passed through environment variables.
```go
inputs = {
    # BYO Resource Group
    resource_group_name      = "nr-spk-infra-tests-rg"
    agent_vm_count           = "3"
    dns_prefix               = "spk-dns-prefix"
    vnet_name                = "spk-vnet"
    service_principal_id          = "${get_env("AZURE_SUBSCRIPTION_ID", "")}"
    service_principal_secret      = "${get_env("AZURE_SUBSCRIPTION_SECRET", "")}"
}
```
Then we create our deployment terraform template directories as subdirectories for our base. In this example we have `azure-simple-east` and `azure-simple-west`. Each contain their respective `terragrunt.hcl` with additional configurations that are specific to their deployment. With our `include` configuration, terraform variables passed from parent branches ared applied to the current child deployment.

```go
include {
  path = find_in_parent_folders()
}

inputs = {
    cluster_name             = "spk-cluster-west"
    ssh_public_key           = "public-key"
    gitops_ssh_url           = "git@github.com:timfpark/fabrikate-cloud-native-manifests.git"
    gitops_ssh_key           = "<path to private gitops repo key>"
}
```

Now that we have our 2 clusters, lets run a terraform plan in both deployment folders.

> User needs to be signed in to az-cli under the correct subscription

First run `terraform get` to download the template modules.

Then run a `terraform plan` in each deployment fold and confirm the configuration.

## Backend State


## Multiple Template Environments


## Embedding in