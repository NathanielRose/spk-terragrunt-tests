# SPK + Infra v3

## `spk infra scaffold`

### SPK & Template Versioning

Spektate will version infrastructure templates based on modification of base HCL files and their respective leaf templates. When an `spk infra update` has modified a parent base, the version is incremented as well as its leaf deployments. If a leaf deployment HCL file is modified, then only that leaf version is incremented
```
include {
  path = find_in_parent_folders()
}

extra_args {
    version = 0.1.1
}

inputs = {
    cluster_name             = "spk-cluster-west"
    ssh_public_key           = "public-key"
    gitops_ssh_url           = "git@github.com:timfpark/fabrikate-cloud-native-manifests.git"
    gitops_ssh_key           = "<path to private gitops repo key>"
}

extra_args{
  init = {
    backend_config = "path/to/backend.tfvar"
  }
}
```
Additional Thoughts:
- Investigation of mapping config template to `tfstate` file (Terraform Workspaces)
- Also provide guidance for alternatively using gitops through Atlantis for versioning.

## `spk infra update`

### SPK & Template Updating - Targeted Day 2 Scenarios

#### **Update Infrastructure Config & Modifications**

- **Update Infrastructure Config & Modifications** - Using `spk infra update` to modify Terragrunt HCL files based on args in a provided template folder (Leaf Deployments). `spk infra update` should be provided an argument (e.g. --template hcl-file / or var) that will pass the path to the leaf deployment definition to either update the hcl file or a var within the hcl file. 

> Example: `spk infra update --template "~/discover-service/cluster-west" --vars "cluster-name=new-cluster-name"`

Expected Day 2 Operations Coverage:
- Node count update 
- Node type
- VM OS upgrades (Without Upgrade Paths)
- Kubernetes Upgrades (Without Upgrade Paths) 

#### **Update Partial Leaf Deployments / Migrating Base**

- **Update Partial Leaf Deployments / Migrating Base** - Using `spk infra update` to create a new base for a subset of leafs to be migrated to a new common configuration for deployment.

> Example: `spk infra update --new-base "azure-simple_v2" --template "~/discover-service/cluster-west" --base-file "new/base/terragrunt.hcl"`

```
└── recursive
    └── azure-simple (base)
        ├── README.md
        ├── terragrunt.hcl
        ├── azure-simple-east (deployment)
        │    ├── main.tf
        │    ├── terragrunt.hcl
        │    └── variables.tf
        └── azure-simple-west (deployment)
             ├── main.tf
             ├── terragrunt.hcl
             └── variables.tf
```
Transfer update
```
└── recursive
    ├── azure-simple (base)
    │   ├── README.md
    │   ├── terragrunt.hcl
    │   ├── azure-simple-east (deployment)
    │   │    ├── main.tf
    │   │    ├── terragrunt.hcl
    │   │    └── variables.tf
    │   └── azure-simple-west (deployment)
    │        ├── main.tf
    │        ├── terragrunt.hcl
    │        └── variables.tf
    └── azure-simple_v2 (base)
        ├── README.md
        ├── terragrunt.hcl
        ├── azure-simple-east_v2 (deployment)
        │    ├── main.tf
        │    ├── terragrunt.hcl
        │    └── variables.tf
``` 

Expected Day 2 Operations Coverage:
- VM OS upgrades (With Upgrade Paths)
- Kubernetes Upgrades (With Upgrade Paths)

#### **Versioning Rolll Back**

-  **Versioning Rolll Back** - Using `spk infra update` I revert configurations for an HCL to a prior version of the template.

> Example: `spk infra update --template "~/discover-service/cluster-west" --version "0.1.2"`

Additional Thoughts:
- Investigation of where versions should be stored
- Also provide guidance for alternatively using gitops through Atlantis for versioning.

### Guard Rails

Additional Thoughts:
- Terragrunt coupled to terraform version restriction
- One level terragrunt config propagation
- `.spk` Management of templates
- Mock config guidance
- Terraform workspaces on multiple deployment configuration
