include {
  path = find_in_parent_folders()
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
