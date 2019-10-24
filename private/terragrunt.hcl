terraform {
  # Github Prvate Repository
  #source = "git@github.com:NathanielRose/spk-terragrunt-private.git//azure-simple-west"
  
  # AzDO Private Repository: Also requires a PAT for user auth
  #source = "git::https://naros32.visualstudio.com/bedrock_testing_phase2/_git/spk-testing-private-azdo"

  # Local Repository Template
  #source = ".bedrock/cluster/environment/azure-simple"

  # Github Public Repository
  source = "git@github.com:microsoft/bedrock.git//cluster/environments/azure-simple?"
}

