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
  }
}

# Configure the Hetzner Cloud Provider with your token
provider "hcloud" {
  token = var.provider_credentials.token
}


provider "autoglue" {
  base_url   = var.autoglue.credentials.base_url
  org_key    = var.autoglue.credentials.autoglue_key
  org_secret = var.autoglue.credentials.autoglue_org_secret
}

provider "aws" {
  alias      = "aws_route53"
  region     = var.autoglue.route_53_config.aws_region
  access_key = var.autoglue.route_53_config.aws_access_key_id
  secret_key = var.autoglue.route_53_config.aws_secret_access_key
}
