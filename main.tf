terraform {
  backend "azurerm" {
    resource_group_name  = "East US"
    storage_account_name = "mytfacc"
    container_name       = "statefile"
    key                  = "nik-app.tfstate"
    subscription_id      = "9bd2fe7b-8da1-4dad-ac7c-7766fe130a05"
    use_azuread_auth   = true
    sas_token = "sv=2022-11-02&ss=bfqt&srt=co&sp=rwdlacupiytfx&se=2025-02-28T13:44:03Z&st=2025-02-28T05:44:03Z&spr=https&sig=Uqv7EEYdSiqmfmBh47mMnvnA%2FpELAOJXU1urSxWN1xc%3D"
  }
}

kkk= ooooo