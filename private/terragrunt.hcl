terraform {
  # Github Public Repository
  #source = "git@github.com:NathanielRose/spk-terragrunt-private.git//azure-simple-west"
  
  # AzDO Private Repository: Also requires a PAT for user auth
  source = "git::https://naros32.visualstudio.com/bedrock_testing_phase2/_git/spk-testing-private-azdo"
}

