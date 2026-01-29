# Tell Terraform to include the hcloud provider
terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.60.0"
    }
    autoglue = {
      source  = "registry.terraform.io/GlueOps/autoglue"
      version = "0.10.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}