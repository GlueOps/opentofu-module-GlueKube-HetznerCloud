# Tell Terraform to include the hcloud provider
terraform {
  required_providers {

    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}